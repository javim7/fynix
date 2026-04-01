-- ─────────────────────────────────────────────────────────────────────────────
-- Fynix — Row Level Security Policies
-- Migration: 002_rls_policies.sql
-- ─────────────────────────────────────────────────────────────────────────────

-- Enable RLS on all tables
ALTER TABLE users                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE integrations            ENABLE ROW LEVEL SECURITY;
ALTER TABLE workouts                ENABLE ROW LEVEL SECURITY;
ALTER TABLE xp_events               ENABLE ROW LEVEL SECURITY;
ALTER TABLE follows                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE feed_posts              ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_likes              ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_comments           ENABLE ROW LEVEL SECURITY;
ALTER TABLE challenges              ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_challenge_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE race_events             ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_event_registrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE badges                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_badges             ENABLE ROW LEVEL SECURITY;
ALTER TABLE avatar_skins            ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_plans          ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_plan_weeks     ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_plan_workouts  ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_active_plans       ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaderboard_weekly      ENABLE ROW LEVEL SECURITY;

-- ─── USERS ────────────────────────────────────────────────────────────────────
-- Any authenticated user can view any profile (for social features)
CREATE POLICY "users_select_any"
  ON users FOR SELECT
  TO authenticated
  USING (true);

-- Users can only update their own row
CREATE POLICY "users_update_own"
  ON users FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Insert is handled by auth trigger / edge function (service role)
-- No direct client insert policy

-- ─── INTEGRATIONS ─────────────────────────────────────────────────────────────
-- Users can only view their own integrations (tokens are server-side only)
CREATE POLICY "integrations_select_own"
  ON integrations FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Tokens are written exclusively by Edge Functions (service role)
-- No client-side insert/update/delete policies

-- ─── WORKOUTS ─────────────────────────────────────────────────────────────────
-- Owner can always read their own workouts
CREATE POLICY "workouts_select_own"
  ON workouts FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Followers can read public workouts (via feed)
CREATE POLICY "workouts_select_followers"
  ON workouts FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM follows
      WHERE follower_id = auth.uid()
        AND following_id = workouts.user_id
    )
  );

-- Workouts are inserted by Edge Functions (service role) — no client policy
-- Owner can update their own (e.g. add caption)
CREATE POLICY "workouts_update_own"
  ON workouts FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ─── XP EVENTS ────────────────────────────────────────────────────────────────
-- Users can only view their own XP history
CREATE POLICY "xp_events_select_own"
  ON xp_events FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- XP is written exclusively by Edge Functions (service role)

-- ─── FOLLOWS ──────────────────────────────────────────────────────────────────
CREATE POLICY "follows_select_any"
  ON follows FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "follows_insert_own"
  ON follows FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = follower_id);

CREATE POLICY "follows_delete_own"
  ON follows FOR DELETE
  TO authenticated
  USING (auth.uid() = follower_id);

-- ─── FEED POSTS ───────────────────────────────────────────────────────────────
-- Any authenticated user can view public posts
CREATE POLICY "feed_posts_select_public"
  ON feed_posts FOR SELECT
  TO authenticated
  USING (is_public = true OR auth.uid() = author_id);

-- Authors can insert their own posts
CREATE POLICY "feed_posts_insert_own"
  ON feed_posts FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = author_id);

-- Authors can update their own posts
CREATE POLICY "feed_posts_update_own"
  ON feed_posts FOR UPDATE
  TO authenticated
  USING (auth.uid() = author_id)
  WITH CHECK (auth.uid() = author_id);

-- Authors can delete their own posts
CREATE POLICY "feed_posts_delete_own"
  ON feed_posts FOR DELETE
  TO authenticated
  USING (auth.uid() = author_id);

-- ─── POST LIKES ───────────────────────────────────────────────────────────────
CREATE POLICY "post_likes_select_any"
  ON post_likes FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "post_likes_insert_own"
  ON post_likes FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "post_likes_delete_own"
  ON post_likes FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- ─── POST COMMENTS ────────────────────────────────────────────────────────────
CREATE POLICY "comments_select_any"
  ON post_comments FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "comments_insert_own"
  ON post_comments FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = author_id);

CREATE POLICY "comments_update_own"
  ON post_comments FOR UPDATE
  TO authenticated
  USING (auth.uid() = author_id)
  WITH CHECK (auth.uid() = author_id);

CREATE POLICY "comments_delete_own"
  ON post_comments FOR DELETE
  TO authenticated
  USING (auth.uid() = author_id);

-- ─── CHALLENGES ───────────────────────────────────────────────────────────────
-- All authenticated users can view challenges
CREATE POLICY "challenges_select_any"
  ON challenges FOR SELECT
  TO authenticated
  USING (true);

-- ─── USER CHALLENGE PROGRESS ──────────────────────────────────────────────────
CREATE POLICY "challenge_progress_select_own"
  ON user_challenge_progress FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "challenge_progress_insert_own"
  ON user_challenge_progress FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "challenge_progress_update_own"
  ON user_challenge_progress FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ─── RACE EVENTS ──────────────────────────────────────────────────────────────
CREATE POLICY "race_events_select_any"
  ON race_events FOR SELECT
  TO authenticated
  USING (true);

-- ─── USER EVENT REGISTRATIONS ─────────────────────────────────────────────────
CREATE POLICY "event_reg_select_own"
  ON user_event_registrations FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "event_reg_insert_own"
  ON user_event_registrations FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "event_reg_update_own"
  ON user_event_registrations FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "event_reg_delete_own"
  ON user_event_registrations FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- ─── BADGES ───────────────────────────────────────────────────────────────────
CREATE POLICY "badges_select_any"
  ON badges FOR SELECT
  TO authenticated
  USING (true);

-- ─── USER BADGES ──────────────────────────────────────────────────────────────
CREATE POLICY "user_badges_select_own"
  ON user_badges FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Badge unlocks are written by Edge Functions (service role)

-- ─── AVATAR SKINS ─────────────────────────────────────────────────────────────
CREATE POLICY "avatar_skins_select_any"
  ON avatar_skins FOR SELECT
  TO authenticated
  USING (true);

-- ─── TRAINING PLANS ───────────────────────────────────────────────────────────
CREATE POLICY "training_plans_select_any"
  ON training_plans FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "training_plan_weeks_select_any"
  ON training_plan_weeks FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "training_plan_workouts_select_any"
  ON training_plan_workouts FOR SELECT
  TO authenticated
  USING (true);

-- ─── USER ACTIVE PLANS ────────────────────────────────────────────────────────
CREATE POLICY "active_plans_select_own"
  ON user_active_plans FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "active_plans_insert_own"
  ON user_active_plans FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "active_plans_update_own"
  ON user_active_plans FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "active_plans_delete_own"
  ON user_active_plans FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- ─── LEADERBOARD ──────────────────────────────────────────────────────────────
-- All authenticated users can view the leaderboard
CREATE POLICY "leaderboard_select_any"
  ON leaderboard_weekly FOR SELECT
  TO authenticated
  USING (true);

-- Leaderboard is refreshed by Edge Function (service role)
