/**
 * Fynix — Badge Checker
 *
 * Evaluates whether a user has unlocked new badges after a workout.
 * Called after XP calculator completes.
 *
 * POST /functions/v1/badge-checker
 * Body: { user_id: string, workout_id?: string }
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

interface Badge {
  id: string;
  condition_type: string;
  condition_sport: string | null;
  condition_value: number;
  xp_reward: number;
  title: string;
}

interface User {
  id: string;
  total_xp: number;
  level: number;
  current_streak: number;
  longest_streak: number;
  total_distance_meters: number;
  total_workouts: number;
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  const { user_id, workout_id } = await req.json();
  if (!user_id) {
    return new Response(JSON.stringify({ error: 'user_id required' }), { status: 400 });
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  // Fetch user stats
  const { data: user } = await supabase
    .from('users')
    .select('id, total_xp, level, current_streak, longest_streak, total_distance_meters, total_workouts')
    .eq('id', user_id)
    .single<User>();

  if (!user) return new Response(JSON.stringify({ error: 'User not found' }), { status: 404 });

  // Fetch all badges not yet unlocked by this user
  const { data: allBadges } = await supabase
    .from('badges')
    .select('id, condition_type, condition_sport, condition_value, xp_reward, title')
    .returns<Badge[]>();

  const { data: unlockedIds } = await supabase
    .from('user_badges')
    .select('badge_id')
    .eq('user_id', user_id);

  const unlockedSet = new Set((unlockedIds ?? []).map((r) => r.badge_id));

  const newlyUnlocked: string[] = [];

  for (const badge of allBadges ?? []) {
    if (unlockedSet.has(badge.id)) continue;

    let unlocked = false;

    switch (badge.condition_type) {
      case 'total_distance':
        // Per-sport or global
        if (badge.condition_sport) {
          // Would need per-sport totals — simplified: check via workout sum
          const { data: sportSum } = await supabase
            .from('workouts')
            .select('distance_meters.sum()')
            .eq('user_id', user_id)
            .eq('sport_type', badge.condition_sport)
            .single<{ sum: number }>();
          unlocked = (sportSum?.sum ?? 0) >= badge.condition_value;
        } else {
          unlocked = user.total_distance_meters >= badge.condition_value;
        }
        break;

      case 'total_workouts':
        unlocked = user.total_workouts >= badge.condition_value;
        break;

      case 'streak':
        unlocked = user.longest_streak >= badge.condition_value;
        break;

      case 'level':
        unlocked = user.level >= badge.condition_value;
        break;

      case 'distance':
        // Single-workout distance — check the triggering workout
        if (workout_id) {
          const { data: workout } = await supabase
            .from('workouts')
            .select('distance_meters, sport_type')
            .eq('id', workout_id)
            .single<{ distance_meters: number; sport_type: string }>();
          const sportMatch = !badge.condition_sport || badge.condition_sport === workout?.sport_type;
          unlocked = sportMatch && (workout?.distance_meters ?? 0) >= badge.condition_value;
        }
        break;
    }

    if (unlocked) {
      // Insert badge unlock
      const { error } = await supabase.from('user_badges').insert({
        user_id,
        badge_id: badge.id,
      });

      if (!error) {
        newlyUnlocked.push(badge.id);

        // Award badge XP
        if (badge.xp_reward > 0) {
          await supabase.from('xp_events').insert({
            user_id,
            source: 'badge',
            xp_amount: badge.xp_reward,
            description: `Badge desbloqueado: ${badge.title}`,
            badge_id: badge.id,
          });

          await supabase.rpc('increment_user_xp', {
            p_user_id: user_id,
            p_xp: badge.xp_reward,
          });
        }
      }
    }
  }

  return new Response(JSON.stringify({ newly_unlocked: newlyUnlocked }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
