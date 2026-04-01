/**
 * Fynix — Streak Evaluator
 *
 * Scheduled daily function (run via cron or pg_cron).
 * For each user: checks if they worked out today or yesterday.
 * Resets streak to 0 if last activity was more than 1 day ago
 * (unless they have a streak freeze available).
 *
 * Schedule: runs daily at 02:00 UTC
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

Deno.serve(async (req: Request) => {
  // Accept GET for cron triggers, POST for manual invocation
  if (req.method !== 'GET' && req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  const today = new Date();
  today.setUTCHours(0, 0, 0, 0);
  const todayStr = today.toISOString().split('T')[0];

  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  const yesterdayStr = yesterday.toISOString().split('T')[0];

  // Fetch all users who have an active streak but didn't work out today
  const { data: usersToCheck, error } = await supabase
    .from('users')
    .select('id, current_streak, longest_streak, last_activity_date, streak_freezes_remaining')
    .gt('current_streak', 0)
    .lt('last_activity_date', todayStr); // didn't work out today

  if (error) {
    console.error('Failed to fetch users:', error);
    return new Response(JSON.stringify({ error: 'DB error' }), { status: 500 });
  }

  let reset = 0;
  let frozen = 0;

  for (const user of usersToCheck ?? []) {
    const lastActivity = user.last_activity_date;

    // If last activity was yesterday, streak is still alive (just no workout today yet)
    if (lastActivity === yesterdayStr) continue;

    // Streak is broken — check for freeze
    if (user.streak_freezes_remaining > 0) {
      // Use a freeze
      await supabase
        .from('users')
        .update({ streak_freezes_remaining: user.streak_freezes_remaining - 1 })
        .eq('id', user.id);
      frozen++;
    } else {
      // Reset streak
      await supabase
        .from('users')
        .update({ current_streak: 0 })
        .eq('id', user.id);
      reset++;
    }
  }

  const summary = {
    evaluated: (usersToCheck ?? []).length,
    streaks_reset: reset,
    streaks_frozen: frozen,
    run_at: new Date().toISOString(),
  };

  console.log('Streak evaluation complete:', summary);

  return new Response(JSON.stringify(summary), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
