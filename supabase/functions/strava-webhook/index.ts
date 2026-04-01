/**
 * Fynix — Strava Webhook Handler
 *
 * Handles Strava push subscription events:
 * - activity:create → import new activity
 * - activity:update → update existing workout
 * - activity:delete → soft-delete or flag workout
 *
 * Also handles the initial GET webhook validation challenge from Strava.
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const STRAVA_VERIFY_TOKEN = Deno.env.get('STRAVA_VERIFY_TOKEN') ?? 'fynix_strava_verify';

// Strava sport type → Fynix sport_type enum
const STRAVA_SPORT_MAP: Record<string, string> = {
  Run: 'running',
  VirtualRun: 'running',
  Ride: 'cycling',
  VirtualRide: 'cycling',
  EBikeRide: 'cycling',
  Swim: 'swimming',
  Walk: 'walking',
  Hike: 'hiking',
  WeightTraining: 'strength',
  Yoga: 'yoga',
  Crossfit: 'crossfit',
  Triathlon: 'triathlon',
};

function mapStravaType(stravaType: string): string {
  return STRAVA_SPORT_MAP[stravaType] ?? 'other';
}

Deno.serve(async (req: Request) => {
  const url = new URL(req.url);

  // ── Webhook verification challenge (GET) ──────────────────────────────────
  if (req.method === 'GET') {
    const mode = url.searchParams.get('hub.mode');
    const token = url.searchParams.get('hub.verify_token');
    const challenge = url.searchParams.get('hub.challenge');

    if (mode === 'subscribe' && token === STRAVA_VERIFY_TOKEN && challenge) {
      return new Response(JSON.stringify({ 'hub.challenge': challenge }), {
        status: 200,
        headers: { 'Content-Type': 'application/json' },
      });
    }
    return new Response('Forbidden', { status: 403 });
  }

  if (req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  const event = await req.json();
  const { object_type, aspect_type, object_id, owner_id } = event;

  // Only handle activity events
  if (object_type !== 'activity') {
    return new Response(JSON.stringify({ status: 'ignored' }), { status: 200 });
  }

  // Find the Fynix user by Strava athlete ID
  const { data: integration } = await supabase
    .from('integrations')
    .select('user_id, access_token')
    .eq('provider', 'strava')
    .eq('provider_user_id', String(owner_id))
    .eq('is_connected', true)
    .single();

  if (!integration) {
    console.warn(`No connected Strava integration found for athlete ${owner_id}`);
    return new Response(JSON.stringify({ status: 'no_user' }), { status: 200 });
  }

  const { user_id, access_token } = integration;

  if (aspect_type === 'create') {
    // Fetch full activity from Strava API
    const activityRes = await fetch(
      `https://www.strava.com/api/v3/activities/${object_id}`,
      { headers: { Authorization: `Bearer ${access_token}` } },
    );

    if (!activityRes.ok) {
      console.error(`Strava API error: ${activityRes.status}`);
      return new Response(JSON.stringify({ error: 'Strava API error' }), { status: 500 });
    }

    const activity = await activityRes.json();

    const workoutData = {
      user_id,
      provider: 'strava',
      provider_activity_id: String(activity.id),
      sport_type: mapStravaType(activity.type),
      name: activity.name,
      description: activity.description,
      started_at: activity.start_date,
      ended_at: activity.start_date, // calculated below
      duration_seconds: activity.moving_time,
      distance_meters: activity.distance ?? 0,
      avg_pace_seconds_per_km: activity.average_speed > 0
        ? Math.round(1000 / activity.average_speed) : null,
      avg_speed_kmh: activity.average_speed ? activity.average_speed * 3.6 : null,
      max_speed_kmh: activity.max_speed ? activity.max_speed * 3.6 : null,
      elevation_gain_meters: activity.total_elevation_gain ?? 0,
      avg_heart_rate: activity.average_heartrate,
      max_heart_rate: activity.max_heartrate,
      calories: activity.calories,
      polyline: activity.map?.summary_polyline,
    };

    // Upsert — idempotent
    const { data: workout, error } = await supabase
      .from('workouts')
      .upsert(workoutData, { onConflict: 'user_id,provider,provider_activity_id', ignoreDuplicates: false })
      .select('id')
      .single();

    if (error) {
      console.error('Failed to upsert workout:', error);
      return new Response(JSON.stringify({ error: 'DB error' }), { status: 500 });
    }

    // Trigger XP calculator
    if (workout?.id) {
      await fetch(`${Deno.env.get('SUPABASE_URL')}/functions/v1/xp-calculator`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
        },
        body: JSON.stringify({ workout_id: workout.id }),
      });
    }

    return new Response(JSON.stringify({ status: 'created', workout_id: workout?.id }), { status: 200 });
  }

  if (aspect_type === 'delete') {
    // Mark as deleted (soft-delete by flagging)
    await supabase
      .from('workouts')
      .update({ is_duplicate: true }) // re-use flag as soft-delete indicator
      .eq('provider', 'strava')
      .eq('provider_activity_id', String(object_id))
      .eq('user_id', user_id);
  }

  return new Response(JSON.stringify({ status: 'ok' }), { status: 200 });
});
