-- ─────────────────────────────────────────────────────────────────────────────
-- Fynix — Initial Database Schema
-- Migration: 001_initial_schema.sql
-- ─────────────────────────────────────────────────────────────────────────────

-- ─── EXTENSIONS ───────────────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis"; -- for route geometry (Phase 2)

-- ─── ENUMS ────────────────────────────────────────────────────────────────────
CREATE TYPE sport_type AS ENUM (
  'running', 'cycling', 'swimming', 'walking', 'hiking',
  'strength', 'yoga', 'crossfit', 'triathlon', 'other'
);

CREATE TYPE subscription_status AS ENUM (
  'free', 'active', 'cancelled', 'expired', 'billing_issue'
);

CREATE TYPE subscription_tier AS ENUM ('free', 'premium');

CREATE TYPE integration_provider AS ENUM (
  'apple_health', 'google_fit', 'strava', 'garmin', 'coros'
);

CREATE TYPE xp_source AS ENUM (
  'workout', 'challenge', 'badge', 'event', 'streak_bonus', 'manual'
);

CREATE TYPE challenge_type AS ENUM (
  'distance', 'duration', 'frequency', 'streak', 'sport_specific', 'event'
);

CREATE TYPE post_type AS ENUM (
  'workout', 'photo', 'milestone', 'challenge_complete', 'event_complete'
);

-- ─── USERS ────────────────────────────────────────────────────────────────────
CREATE TABLE users (
  id                          UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username                    TEXT UNIQUE NOT NULL,
  display_name                TEXT NOT NULL,
  email                       TEXT UNIQUE NOT NULL,
  bio                         TEXT,
  avatar_id                   TEXT DEFAULT 'default',
  city                        TEXT,
  country                     TEXT DEFAULT 'GT',

  -- Gamification
  level                       INTEGER NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 100),
  total_xp                    INTEGER NOT NULL DEFAULT 0 CHECK (total_xp >= 0),
  xp_to_next_level            INTEGER NOT NULL DEFAULT 500,
  current_streak              INTEGER NOT NULL DEFAULT 0 CHECK (current_streak >= 0),
  longest_streak              INTEGER NOT NULL DEFAULT 0 CHECK (longest_streak >= 0),
  last_activity_date          DATE,
  streak_freezes_remaining    INTEGER NOT NULL DEFAULT 0,

  -- Social
  following_count             INTEGER NOT NULL DEFAULT 0 CHECK (following_count >= 0),
  follower_count              INTEGER NOT NULL DEFAULT 0 CHECK (follower_count >= 0),

  -- Totals (denormalized for fast profile rendering)
  total_workouts              INTEGER NOT NULL DEFAULT 0,
  total_distance_meters       BIGINT NOT NULL DEFAULT 0,
  total_duration_seconds      BIGINT NOT NULL DEFAULT 0,

  -- Subscription
  subscription_status         subscription_status NOT NULL DEFAULT 'free',
  subscription_tier           subscription_tier NOT NULL DEFAULT 'free',
  subscription_expires_at     TIMESTAMPTZ,
  revenuecat_customer_id      TEXT,

  created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_username  ON users(username);
CREATE INDEX idx_users_city      ON users(city);
CREATE INDEX idx_users_total_xp  ON users(total_xp DESC);

-- ─── INTEGRATIONS ─────────────────────────────────────────────────────────────
CREATE TABLE integrations (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  provider            integration_provider NOT NULL,
  is_connected        BOOLEAN NOT NULL DEFAULT false,
  access_token        TEXT,           -- encrypted at application level
  refresh_token       TEXT,           -- encrypted at application level
  token_expires_at    TIMESTAMPTZ,
  provider_user_id    TEXT,
  provider_username   TEXT,
  last_synced_at      TIMESTAMPTZ,
  last_sync_cursor    TEXT,
  sync_error          TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  UNIQUE (user_id, provider)
);

CREATE INDEX idx_integrations_user_id ON integrations(user_id);

-- ─── WORKOUTS ─────────────────────────────────────────────────────────────────
CREATE TABLE workouts (
  id                      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id                 UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  integration_id          UUID REFERENCES integrations(id) ON DELETE SET NULL,
  provider                integration_provider,
  provider_activity_id    TEXT,

  sport_type              sport_type NOT NULL,
  name                    TEXT,
  description             TEXT,

  -- Timing
  started_at              TIMESTAMPTZ NOT NULL,
  ended_at                TIMESTAMPTZ,
  duration_seconds        INTEGER NOT NULL CHECK (duration_seconds > 0),

  -- Distance & Pace
  distance_meters         NUMERIC(10,2) DEFAULT 0,
  avg_pace_seconds_per_km NUMERIC(8,2),
  avg_speed_kmh           NUMERIC(6,2),
  max_speed_kmh           NUMERIC(6,2),

  -- Elevation
  elevation_gain_meters   NUMERIC(8,2) DEFAULT 0,
  elevation_loss_meters   NUMERIC(8,2) DEFAULT 0,

  -- Biometrics
  avg_heart_rate          INTEGER,
  max_heart_rate          INTEGER,
  calories                INTEGER,

  -- Route
  polyline                TEXT,
  map_snapshot_url        TEXT,

  -- Splits
  splits                  JSONB DEFAULT '[]',

  -- XP
  xp_earned               INTEGER NOT NULL DEFAULT 0,
  xp_breakdown            JSONB,

  -- Deduplication
  is_duplicate            BOOLEAN NOT NULL DEFAULT false,

  created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  UNIQUE (user_id, provider, provider_activity_id)
);

CREATE INDEX idx_workouts_user_id    ON workouts(user_id);
CREATE INDEX idx_workouts_started_at ON workouts(started_at DESC);
CREATE INDEX idx_workouts_sport_type ON workouts(sport_type);
CREATE INDEX idx_workouts_user_date  ON workouts(user_id, started_at DESC);

-- ─── XP EVENTS ────────────────────────────────────────────────────────────────
-- Forward-declare badges and challenges tables referenced below via FK
-- (defined later; use DEFERRABLE FK if needed, or add FKs in a later migration)

CREATE TABLE challenges (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  challenge_type  challenge_type NOT NULL,
  title           TEXT NOT NULL,
  description     TEXT,
  sport_type      sport_type,
  target_value    NUMERIC(10,2) NOT NULL,
  target_unit     TEXT NOT NULL,
  xp_reward       INTEGER NOT NULL CHECK (xp_reward > 0),
  is_daily        BOOLEAN NOT NULL DEFAULT true,
  is_premium      BOOLEAN NOT NULL DEFAULT false,
  icon            TEXT,
  starts_at       TIMESTAMPTZ,
  expires_at      TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_challenges_expires ON challenges(expires_at);
CREATE INDEX idx_challenges_daily   ON challenges(is_daily, expires_at);

CREATE TABLE badges (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title           TEXT NOT NULL,
  description     TEXT NOT NULL,
  icon_asset      TEXT NOT NULL,
  condition_type  TEXT NOT NULL,
  condition_sport sport_type,
  condition_value NUMERIC(12,2) NOT NULL,
  xp_reward       INTEGER NOT NULL DEFAULT 0,
  is_premium      BOOLEAN NOT NULL DEFAULT false,
  sort_order      INTEGER NOT NULL DEFAULT 0,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE race_events (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title            TEXT NOT NULL,
  description      TEXT,
  sport_type       sport_type NOT NULL DEFAULT 'running',
  distance_meters  INTEGER,
  location         TEXT,
  city             TEXT,
  country          TEXT DEFAULT 'GT',
  event_date       DATE NOT NULL,
  registration_url TEXT,
  image_url        TEXT,
  xp_reward        INTEGER NOT NULL DEFAULT 0,
  bonus_xp_reward  INTEGER NOT NULL DEFAULT 0,
  is_featured      BOOLEAN NOT NULL DEFAULT false,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_race_events_date ON race_events(event_date);
CREATE INDEX idx_race_events_city ON race_events(city);

CREATE TABLE xp_events (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  source          xp_source NOT NULL,
  xp_amount       INTEGER NOT NULL CHECK (xp_amount > 0),
  description     TEXT NOT NULL,

  workout_id      UUID REFERENCES workouts(id) ON DELETE SET NULL,
  challenge_id    UUID REFERENCES challenges(id) ON DELETE SET NULL,
  badge_id        UUID REFERENCES badges(id) ON DELETE SET NULL,
  event_id        UUID REFERENCES race_events(id) ON DELETE SET NULL,

  metadata        JSONB,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_xp_events_user_id    ON xp_events(user_id);
CREATE INDEX idx_xp_events_created_at ON xp_events(created_at DESC);
CREATE INDEX idx_xp_events_user_date  ON xp_events(user_id, created_at DESC);

-- ─── FOLLOWS ──────────────────────────────────────────────────────────────────
CREATE TABLE follows (
  follower_id   UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  following_id  UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  PRIMARY KEY (follower_id, following_id),
  CHECK (follower_id != following_id)
);

CREATE INDEX idx_follows_follower  ON follows(follower_id);
CREATE INDEX idx_follows_following ON follows(following_id);

-- ─── FEED POSTS ───────────────────────────────────────────────────────────────
CREATE TABLE feed_posts (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  author_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  workout_id    UUID REFERENCES workouts(id) ON DELETE SET NULL,
  post_type     post_type NOT NULL DEFAULT 'workout',
  caption       TEXT,
  image_url     TEXT,
  like_count    INTEGER NOT NULL DEFAULT 0 CHECK (like_count >= 0),
  comment_count INTEGER NOT NULL DEFAULT 0 CHECK (comment_count >= 0),
  is_public     BOOLEAN NOT NULL DEFAULT true,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_feed_posts_author  ON feed_posts(author_id);
CREATE INDEX idx_feed_posts_created ON feed_posts(created_at DESC);
CREATE INDEX idx_feed_posts_workout ON feed_posts(workout_id);

-- ─── POST LIKES ───────────────────────────────────────────────────────────────
CREATE TABLE post_likes (
  post_id     UUID NOT NULL REFERENCES feed_posts(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  PRIMARY KEY (post_id, user_id)
);

CREATE INDEX idx_post_likes_post ON post_likes(post_id);
CREATE INDEX idx_post_likes_user ON post_likes(user_id);

-- ─── POST COMMENTS ────────────────────────────────────────────────────────────
CREATE TABLE post_comments (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_id     UUID NOT NULL REFERENCES feed_posts(id) ON DELETE CASCADE,
  author_id   UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  content     TEXT NOT NULL CHECK (char_length(content) BETWEEN 1 AND 500),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_comments_post   ON post_comments(post_id);
CREATE INDEX idx_comments_author ON post_comments(author_id);

-- ─── USER CHALLENGE PROGRESS ──────────────────────────────────────────────────
CREATE TABLE user_challenge_progress (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  challenge_id    UUID NOT NULL REFERENCES challenges(id) ON DELETE CASCADE,
  progress_value  NUMERIC(10,2) NOT NULL DEFAULT 0,
  is_completed    BOOLEAN NOT NULL DEFAULT false,
  completed_at    TIMESTAMPTZ,
  xp_awarded      BOOLEAN NOT NULL DEFAULT false,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  UNIQUE (user_id, challenge_id)
);

CREATE INDEX idx_challenge_progress_user      ON user_challenge_progress(user_id);
CREATE INDEX idx_challenge_progress_challenge ON user_challenge_progress(challenge_id);

-- ─── USER EVENT REGISTRATIONS ─────────────────────────────────────────────────
CREATE TABLE user_event_registrations (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  event_id            UUID NOT NULL REFERENCES race_events(id) ON DELETE CASCADE,
  registered_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed           BOOLEAN NOT NULL DEFAULT false,
  completed_at        TIMESTAMPTZ,
  finish_time_seconds INTEGER,
  xp_awarded          BOOLEAN NOT NULL DEFAULT false,
  linked_workout_id   UUID REFERENCES workouts(id) ON DELETE SET NULL,

  UNIQUE (user_id, event_id)
);

CREATE INDEX idx_event_registrations_user  ON user_event_registrations(user_id);
CREATE INDEX idx_event_registrations_event ON user_event_registrations(event_id);

-- ─── USER BADGES ──────────────────────────────────────────────────────────────
CREATE TABLE user_badges (
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  badge_id    UUID NOT NULL REFERENCES badges(id) ON DELETE CASCADE,
  unlocked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  PRIMARY KEY (user_id, badge_id)
);

CREATE INDEX idx_user_badges_user ON user_badges(user_id);

-- ─── AVATAR SKINS ─────────────────────────────────────────────────────────────
CREATE TABLE avatar_skins (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name            TEXT NOT NULL,
  asset_path      TEXT NOT NULL,
  level_required  INTEGER NOT NULL DEFAULT 1,
  is_premium      BOOLEAN NOT NULL DEFAULT false,
  sort_order      INTEGER NOT NULL DEFAULT 0
);

-- ─── TRAINING PLANS ───────────────────────────────────────────────────────────
CREATE TABLE training_plans (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title           TEXT NOT NULL,
  sport_type      sport_type NOT NULL DEFAULT 'running',
  target_distance TEXT NOT NULL,
  level           TEXT NOT NULL,
  duration_weeks  INTEGER NOT NULL,
  description     TEXT,
  is_premium      BOOLEAN NOT NULL DEFAULT true,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE training_plan_weeks (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  plan_id     UUID NOT NULL REFERENCES training_plans(id) ON DELETE CASCADE,
  week_number INTEGER NOT NULL,
  focus       TEXT NOT NULL,
  description TEXT,

  UNIQUE (plan_id, week_number)
);

CREATE TABLE training_plan_workouts (
  id                      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  week_id                 UUID NOT NULL REFERENCES training_plan_weeks(id) ON DELETE CASCADE,
  day_number              INTEGER NOT NULL CHECK (day_number BETWEEN 1 AND 7),
  workout_type            TEXT NOT NULL,
  title                   TEXT NOT NULL,
  description             TEXT,
  target_distance_meters  INTEGER,
  target_duration_seconds INTEGER,
  instructions            TEXT,

  UNIQUE (week_id, day_number)
);

-- ─── USER ACTIVE PLANS ────────────────────────────────────────────────────────
CREATE TABLE user_active_plans (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  plan_id      UUID NOT NULL REFERENCES training_plans(id) ON DELETE CASCADE,
  started_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  current_week INTEGER NOT NULL DEFAULT 1,
  current_day  INTEGER NOT NULL DEFAULT 1,
  is_active    BOOLEAN NOT NULL DEFAULT true,
  completed_at TIMESTAMPTZ,

  UNIQUE (user_id, plan_id)
);

-- ─── LEADERBOARD ──────────────────────────────────────────────────────────────
CREATE TABLE leaderboard_weekly (
  id                    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id               UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  week_start            DATE NOT NULL,
  total_xp              INTEGER NOT NULL DEFAULT 0,
  total_distance_meters BIGINT NOT NULL DEFAULT 0,
  workout_count         INTEGER NOT NULL DEFAULT 0,
  rank                  INTEGER,
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  UNIQUE (user_id, week_start)
);

CREATE INDEX idx_leaderboard_week ON leaderboard_weekly(week_start, total_xp DESC);
CREATE INDEX idx_leaderboard_user ON leaderboard_weekly(user_id);

-- ─── TRIGGERS: updated_at ─────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated_at
  BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_integrations_updated_at
  BEFORE UPDATE ON integrations FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_workouts_updated_at
  BEFORE UPDATE ON workouts FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_feed_posts_updated_at
  BEFORE UPDATE ON feed_posts FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_comments_updated_at
  BEFORE UPDATE ON post_comments FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_challenge_prog_updated_at
  BEFORE UPDATE ON user_challenge_progress FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ─── TRIGGER: follow counts ───────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_follow_counts()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE users SET following_count = following_count + 1 WHERE id = NEW.follower_id;
    UPDATE users SET follower_count  = follower_count  + 1 WHERE id = NEW.following_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE users SET following_count = GREATEST(following_count - 1, 0) WHERE id = OLD.follower_id;
    UPDATE users SET follower_count  = GREATEST(follower_count  - 1, 0) WHERE id = OLD.following_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_follow_counts
  AFTER INSERT OR DELETE ON follows
  FOR EACH ROW EXECUTE FUNCTION update_follow_counts();

-- ─── TRIGGER: like count ──────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_like_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE feed_posts SET like_count = like_count + 1 WHERE id = NEW.post_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE feed_posts SET like_count = GREATEST(like_count - 1, 0) WHERE id = OLD.post_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_like_count
  AFTER INSERT OR DELETE ON post_likes
  FOR EACH ROW EXECUTE FUNCTION update_like_count();

-- ─── TRIGGER: comment count ───────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_comment_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE feed_posts SET comment_count = comment_count + 1 WHERE id = NEW.post_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE feed_posts SET comment_count = GREATEST(comment_count - 1, 0) WHERE id = OLD.post_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_comment_count
  AFTER INSERT OR DELETE ON post_comments
  FOR EACH ROW EXECUTE FUNCTION update_comment_count();
