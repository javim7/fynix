/**
 * Fynix — Health Sync Processor
 *
 * Processes Apple Health / Google Fit workout data sent from the Flutter app.
 * The Flutter `health` package reads workouts from HealthKit/Google Fit and
 * POSTs them here for server-side processing, deduplication, and XP calculation.
 *
 * POST /functions/v1/health-sync
 * Body: { user_id: string, provider: 'apple_health' | 'google_fit', workouts: HealthWorkout[] }
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

interface HealthWorkout {
  provider_activity_id: string;
  sport_type: string;
  started_at: string;
  ended_at: string;
  duration_seconds: number;
  distance_meters?: number;
  calories?: number;
  avg_heart_rate?: number;
  max_heart_rate?: number;
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  const authHeader = req.headers.get('Authorization') ?? '';
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_ANON_KEY')!,
    { global: { headers: { Authorization: authHeader } } },
  );

  // Verify the authenticated user
  const { data: { user }, error: authErr } = await supabase.auth.getUser();
  if (authErr || !user) {
    return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 });
  }

  const { provider, workouts } = await req.json() as {
    provider: 'apple_health' | 'google_fit';
    workouts: HealthWorkout[];
  };

  if (!Array.isArray(workouts) || workouts.length === 0) {
    return new Response(JSON.stringify({ error: 'No workouts provided' }), { status: 400 });
  }

  const supabaseAdmin = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  // Fetch existing Strava workouts to detect duplicates
  const startDates = workouts.map((w) => w.started_at);
  const { data: existingStrava } = await supabaseAdmin
    .from('workouts')
    .select('started_at, sport_type')
    .eq('user_id', user.id)
    .eq('provider', 'strava')
    .in('started_at', startDates);

  const stravaSet = new Set(
    (existingStrava ?? []).map((w) => `${w.started_at}|${w.sport_type}`),
  );

  let imported = 0;
  let duplicates = 0;
  const newWorkoutIds: string[] = [];

  for (const w of workouts) {
    // Deduplication: if Strava already has this workout (within ±5 min, same sport),
    // mark it as duplicate
    const startTime = new Date(w.started_at).getTime();
    const fiveMin = 5 * 60 * 1000;
    const isDuplicate = (existingStrava ?? []).some((s) => {
      const diff = Math.abs(new Date(s.started_at).getTime() - startTime);
      return diff <= fiveMin && s.sport_type === w.sport_type;
    });

    const workoutData = {
      user_id: user.id,
      provider,
      provider_activity_id: w.provider_activity_id,
      sport_type: w.sport_type,
      started_at: w.started_at,
      ended_at: w.ended_at,
      duration_seconds: w.duration_seconds,
      distance_meters: w.distance_meters ?? 0,
      calories: w.calories,
      avg_heart_rate: w.avg_heart_rate,
      max_heart_rate: w.max_heart_rate,
      is_duplicate: isDuplicate,
    };

    const { data: inserted, error } = await supabaseAdmin
      .from('workouts')
      .upsert(workoutData, {
        onConflict: 'user_id,provider,provider_activity_id',
        ignoreDuplicates: true,
      })
      .select('id')
      .single();

    if (!error && inserted?.id && !isDuplicate) {
      newWorkoutIds.push(inserted.id);
      imported++;
    } else if (isDuplicate) {
      duplicates++;
    }
  }

  // Trigger XP calculator for each new workout
  for (const workoutId of newWorkoutIds) {
    fetch(`${Deno.env.get('SUPABASE_URL')}/functions/v1/xp-calculator`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
      },
      body: JSON.stringify({ workout_id: workoutId }),
    }).catch(console.error);
  }

  // Update last_synced_at
  await supabaseAdmin
    .from('integrations')
    .update({ last_synced_at: new Date().toISOString() })
    .eq('user_id', user.id)
    .eq('provider', provider);

  return new Response(JSON.stringify({
    imported,
    duplicates,
    total: workouts.length,
  }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
