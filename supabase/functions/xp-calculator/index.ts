/**
 * Fynix XP Calculator — Supabase Edge Function
 *
 * Authoritative XP calculation for all workout syncs.
 * Called after a workout is inserted. Computes XP, writes xp_events,
 * and updates users.total_xp + users.level.
 *
 * Invoke: POST /functions/v1/xp-calculator
 * Body: { workout_id: string }
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

// ─── Types ──────────────────────────────────────────────────────────────────
type SportType =
  | 'running' | 'cycling' | 'swimming' | 'walking' | 'hiking'
  | 'strength' | 'yoga' | 'crossfit' | 'triathlon' | 'other';

interface Workout {
  id: string;
  user_id: string;
  sport_type: SportType;
  distance_meters: number;
  duration_seconds: number;
  started_at: string;
  xp_earned: number;
}

interface User {
  id: string;
  total_xp: number;
  current_streak: number;
}

interface XpBreakdown {
  base_xp: number;
  streak_bonus: number;
  pr_bonus: number;
  morning_bonus: number;
  total: number;
  rate_per_km?: number;
  distance_km: number;
  sport: SportType;
}

// ─── XP Rates ───────────────────────────────────────────────────────────────
const RATE_PER_KM: Partial<Record<SportType, number>> = {
  running: 10,
  swimming: 30,
  cycling: 3,
  walking: 5,
  hiking: 8,
};

const RATE_PER_HOUR: Partial<Record<SportType, number>> = {
  strength: 50,
  yoga: 40,
  crossfit: 60,
  other: 50,
};

// ─── XP Calculation ─────────────────────────────────────────────────────────
function calculateBaseXp(sport: SportType, distanceMeters: number, durationSeconds: number): {
  baseXp: number;
  ratePerKm?: number;
  distanceKm: number;
} {
  const distanceKm = distanceMeters / 1000;
  const durationHours = durationSeconds / 3600;

  if (sport in RATE_PER_KM) {
    const rate = RATE_PER_KM[sport]!;
    return { baseXp: Math.round(distanceKm * rate), ratePerKm: rate, distanceKm };
  }

  if (sport in RATE_PER_HOUR) {
    const rate = RATE_PER_HOUR[sport]!;
    return { baseXp: Math.round(durationHours * rate), distanceKm };
  }

  // Triathlon: approximate as duration-based at 50 XP/hr
  return { baseXp: Math.round(durationHours * 50), distanceKm };
}

function streakMultiplier(streakDays: number): number {
  if (streakDays >= 90) return 0.50;
  if (streakDays >= 30) return 0.30;
  if (streakDays >= 14) return 0.20;
  if (streakDays >= 7) return 0.10;
  return 0;
}

function isMorningWorkout(startedAt: string): boolean {
  const date = new Date(startedAt);
  const hour = date.getHours(); // UTC — adjust if storing local time
  return hour >= 5 && hour < 7;
}

function xpForLevel(level: number): number {
  if (level <= 1) return 0;
  return Math.floor(400 * Math.pow(level, 1.5));
}

function levelFromXp(totalXp: number): number {
  let low = 1;
  let high = 100;
  while (low < high) {
    const mid = Math.ceil((low + high) / 2);
    if (xpForLevel(mid) <= totalXp) low = mid;
    else high = mid - 1;
  }
  return low;
}

function xpToNextLevel(totalXp: number): number {
  const level = levelFromXp(totalXp);
  if (level >= 100) return 0;
  return xpForLevel(level + 1) - totalXp;
}

// ─── Handler ─────────────────────────────────────────────────────────────────
Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  const { workout_id } = await req.json();
  if (!workout_id) {
    return new Response(JSON.stringify({ error: 'workout_id is required' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Fetch workout
  const { data: workout, error: workoutErr } = await supabase
    .from('workouts')
    .select('id, user_id, sport_type, distance_meters, duration_seconds, started_at, xp_earned')
    .eq('id', workout_id)
    .single<Workout>();

  if (workoutErr || !workout) {
    return new Response(JSON.stringify({ error: 'Workout not found' }), {
      status: 404,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Skip if already processed
  if (workout.xp_earned > 0) {
    return new Response(JSON.stringify({ message: 'XP already calculated', xp: workout.xp_earned }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Fetch user
  const { data: user, error: userErr } = await supabase
    .from('users')
    .select('id, total_xp, current_streak')
    .eq('id', workout.user_id)
    .single<User>();

  if (userErr || !user) {
    return new Response(JSON.stringify({ error: 'User not found' }), {
      status: 404,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // ── Calculate XP ─────────────────────────────────────────────────────────
  const { baseXp, ratePerKm, distanceKm } = calculateBaseXp(
    workout.sport_type,
    Number(workout.distance_meters),
    workout.duration_seconds,
  );

  const streakMult = streakMultiplier(user.current_streak);
  const streakBonus = Math.round(baseXp * streakMult);
  const morningBonus = isMorningWorkout(workout.started_at) ? 5 : 0;
  const prBonus = 0; // PR detection handled by badge-checker after this function

  const totalXp = baseXp + streakBonus + morningBonus + prBonus;

  const breakdown: XpBreakdown = {
    base_xp: baseXp,
    streak_bonus: streakBonus,
    pr_bonus: prBonus,
    morning_bonus: morningBonus,
    total: totalXp,
    rate_per_km: ratePerKm,
    distance_km: distanceKm,
    sport: workout.sport_type,
  };

  // ── Write workout XP ──────────────────────────────────────────────────────
  const { error: updateErr } = await supabase
    .from('workouts')
    .update({ xp_earned: totalXp, xp_breakdown: breakdown })
    .eq('id', workout_id);

  if (updateErr) {
    console.error('Failed to update workout XP:', updateErr);
    return new Response(JSON.stringify({ error: 'Failed to update workout' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // ── Create XP event ───────────────────────────────────────────────────────
  const description = `${distanceKm.toFixed(1)} km ${workout.sport_type} — ${baseXp} XP base`;
  await supabase.from('xp_events').insert({
    user_id: workout.user_id,
    source: 'workout',
    xp_amount: totalXp,
    description,
    workout_id: workout.id,
    metadata: breakdown,
  });

  // ── Update user total XP and level ────────────────────────────────────────
  const newTotalXp = user.total_xp + totalXp;
  const newLevel = levelFromXp(newTotalXp);
  const newXpToNext = xpToNextLevel(newTotalXp);

  await supabase
    .from('users')
    .update({
      total_xp: newTotalXp,
      level: newLevel,
      xp_to_next_level: newXpToNext,
      total_workouts: supabase.rpc('increment', { table: 'users', column: 'total_workouts' }),
    })
    .eq('id', workout.user_id);

  return new Response(JSON.stringify({ xp: totalXp, breakdown, new_level: newLevel }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
