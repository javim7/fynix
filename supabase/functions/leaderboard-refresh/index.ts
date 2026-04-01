/**
 * Fynix — Leaderboard Refresh
 *
 * Aggregates weekly XP for all users and upserts into leaderboard_weekly.
 * Scheduled to run every Monday at 00:05 UTC to close the previous week.
 *
 * Also invokable manually: POST /functions/v1/leaderboard-refresh
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

function getWeekStart(date: Date): string {
  const d = new Date(date);
  const day = d.getUTCDay(); // 0=Sun, 1=Mon
  const diff = day === 0 ? -6 : 1 - day; // adjust to Monday
  d.setUTCDate(d.getUTCDate() + diff);
  d.setUTCHours(0, 0, 0, 0);
  return d.toISOString().split('T')[0];
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'GET' && req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  // Default: refresh the current week
  const body = req.method === 'POST' ? await req.json().catch(() => ({})) : {};
  const weekStart = body.week_start ?? getWeekStart(new Date());

  const weekStartDate = new Date(weekStart);
  const weekEndDate = new Date(weekStartDate);
  weekEndDate.setDate(weekEndDate.getDate() + 7);

  const weekEndStr = weekEndDate.toISOString();

  // Aggregate XP events for the week
  const { data: aggregated, error } = await supabase
    .from('xp_events')
    .select('user_id, xp_amount')
    .gte('created_at', weekStart)
    .lt('created_at', weekEndStr);

  if (error) {
    console.error('Failed to aggregate XP events:', error);
    return new Response(JSON.stringify({ error: 'DB error' }), { status: 500 });
  }

  // Sum XP per user
  const userTotals = new Map<string, number>();
  for (const row of aggregated ?? []) {
    userTotals.set(row.user_id, (userTotals.get(row.user_id) ?? 0) + row.xp_amount);
  }

  // Also aggregate workout counts and distance
  const { data: workoutAgg } = await supabase
    .from('workouts')
    .select('user_id, distance_meters')
    .gte('started_at', weekStart)
    .lt('started_at', weekEndStr)
    .eq('is_duplicate', false);

  const workoutCounts = new Map<string, number>();
  const distanceTotals = new Map<string, number>();
  for (const row of workoutAgg ?? []) {
    workoutCounts.set(row.user_id, (workoutCounts.get(row.user_id) ?? 0) + 1);
    distanceTotals.set(
      row.user_id,
      (distanceTotals.get(row.user_id) ?? 0) + (row.distance_meters ?? 0),
    );
  }

  // Upsert leaderboard rows
  const rows = Array.from(userTotals.entries()).map(([userId, totalXp]) => ({
    user_id: userId,
    week_start: weekStart,
    total_xp: totalXp,
    workout_count: workoutCounts.get(userId) ?? 0,
    total_distance_meters: distanceTotals.get(userId) ?? 0,
    updated_at: new Date().toISOString(),
  }));

  if (rows.length > 0) {
    const { error: upsertErr } = await supabase
      .from('leaderboard_weekly')
      .upsert(rows, { onConflict: 'user_id,week_start' });

    if (upsertErr) {
      console.error('Failed to upsert leaderboard:', upsertErr);
      return new Response(JSON.stringify({ error: 'Upsert failed' }), { status: 500 });
    }

    // Update rank within the week
    await supabase.rpc('refresh_leaderboard_ranks', { p_week_start: weekStart });
  }

  return new Response(JSON.stringify({
    week_start: weekStart,
    users_updated: rows.length,
    run_at: new Date().toISOString(),
  }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
