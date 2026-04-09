-- ─────────────────────────────────────────────────────────────────────────────
-- Simulated event challenges, medals, Embers balance, partner vouchers
-- Migration: 004_simulated_events_promotions.sql
-- ─────────────────────────────────────────────────────────────────────────────

-- ─── USERS: Embers balance ───────────────────────────────────────────────────
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS embers_balance INTEGER NOT NULL DEFAULT 120
    CHECK (embers_balance >= 0);

COMMENT ON COLUMN users.embers_balance IS 'In-app currency; separate from real-money partner checkout';

-- ─── RACE EVENTS: simulation + matching rules ─────────────────────────────────
ALTER TABLE race_events
  ADD COLUMN IF NOT EXISTS match_window_start TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS match_window_end   TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS venue_lat           DOUBLE PRECISION,
  ADD COLUMN IF NOT EXISTS venue_lng           DOUBLE PRECISION,
  ADD COLUMN IF NOT EXISTS match_radius_meters INTEGER NOT NULL DEFAULT 25000,
  ADD COLUMN IF NOT EXISTS embers_signup_cost  INTEGER NOT NULL DEFAULT 25
    CHECK (embers_signup_cost >= 0),
  ADD COLUMN IF NOT EXISTS medal_title        TEXT,
  ADD COLUMN IF NOT EXISTS medal_asset_key    TEXT,
  ADD COLUMN IF NOT EXISTS is_simulation      BOOLEAN NOT NULL DEFAULT true,
  ADD COLUMN IF NOT EXISTS distance_tolerance_percent NUMERIC(5,2) NOT NULL DEFAULT 8.0
    CHECK (distance_tolerance_percent >= 0 AND distance_tolerance_percent <= 50);

COMMENT ON COLUMN race_events.is_simulation IS 'If true, in-app reto only — not official race registration';
COMMENT ON COLUMN race_events.match_window_start IS 'Activity started_at must be >= this (UTC)';
COMMENT ON COLUMN race_events.match_window_end IS 'Activity started_at must be <= this (UTC)';

-- Default windows from event_date where missing (UTC midnight + generous window)
UPDATE race_events SET
  match_window_start = COALESCE(match_window_start, event_date::timestamp AT TIME ZONE 'UTC' - interval '12 hours'),
  match_window_end   = COALESCE(match_window_end,   event_date::timestamp AT TIME ZONE 'UTC' + interval '48 hours')
WHERE match_window_start IS NULL OR match_window_end IS NULL;

-- Guatemala City approx center for seeded races
UPDATE race_events SET
  venue_lat = COALESCE(venue_lat, 14.6349),
  venue_lng = COALESCE(venue_lng, -90.5069)
WHERE city ILIKE '%guatemala%' OR location ILIKE '%guatemala%';

UPDATE race_events SET
  medal_title = COALESCE(medal_title, 'Medalla ' || title),
  medal_asset_key = COALESCE(medal_asset_key, 'medal_default')
WHERE medal_title IS NULL;

-- ─── USER EVENT REGISTRATIONS: Embers stake ───────────────────────────────────
ALTER TABLE user_event_registrations
  ADD COLUMN IF NOT EXISTS embers_stake_paid INTEGER NOT NULL DEFAULT 0 CHECK (embers_stake_paid >= 0),
  ADD COLUMN IF NOT EXISTS stake_refunded    BOOLEAN NOT NULL DEFAULT false;

-- ─── USER MEDALS (one row per user per event instance completed) ────────────
CREATE TABLE IF NOT EXISTS user_medals (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  event_id        UUID NOT NULL REFERENCES race_events(id) ON DELETE CASCADE,
  workout_id      UUID REFERENCES workouts(id) ON DELETE SET NULL,
  medal_title     TEXT NOT NULL,
  medal_asset_key TEXT NOT NULL,
  earned_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  UNIQUE (user_id, event_id)
);

CREATE INDEX IF NOT EXISTS idx_user_medals_user ON user_medals(user_id);
CREATE INDEX IF NOT EXISTS idx_user_medals_event ON user_medals(event_id);

-- ─── EMBER LEDGER ────────────────────────────────────────────────────────────
CREATE TYPE ember_ledger_reason AS ENUM (
  'event_signup',
  'event_stake_refund',
  'partner_voucher',
  'admin_adjust',
  'challenge_reward',
  'store_purchase'
);

CREATE TABLE IF NOT EXISTS ember_ledger (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  amount          INTEGER NOT NULL,
  balance_after   INTEGER NOT NULL CHECK (balance_after >= 0),
  reason          ember_ledger_reason NOT NULL,
  ref_type        TEXT,
  ref_id          UUID,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_ember_ledger_user ON ember_ledger(user_id, created_at DESC);

-- ─── PARTNER PROMOTIONS (in-app offers, redeem in store) ─────────────────────
CREATE TABLE IF NOT EXISTS partner_promotions (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  brand_name      TEXT NOT NULL,
  title           TEXT NOT NULL,
  subtitle        TEXT,
  embers_cost     INTEGER NOT NULL CHECK (embers_cost > 0),
  terms           TEXT,
  valid_until     TIMESTAMPTZ NOT NULL,
  active          BOOLEAN NOT NULL DEFAULT true,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_partner_promotions_active ON partner_promotions(active, valid_until);

-- ─── USER PARTNER VOUCHERS ───────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS user_partner_vouchers (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  promotion_id    UUID NOT NULL REFERENCES partner_promotions(id) ON DELETE CASCADE,
  redeem_code     TEXT NOT NULL UNIQUE,
  qr_payload      TEXT NOT NULL,
  expires_at      TIMESTAMPTZ NOT NULL,
  redeemed_at     TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_vouchers_user ON user_partner_vouchers(user_id);
CREATE INDEX IF NOT EXISTS idx_vouchers_code ON user_partner_vouchers(redeem_code);

-- ─── RPC: join simulated event (atomic Embers debit + registration) ─────────
CREATE OR REPLACE FUNCTION public.join_event_challenge(p_event_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_user UUID := auth.uid();
  v_cost INTEGER;
  v_bal  INTEGER;
BEGIN
  IF v_user IS NULL THEN
    RETURN jsonb_build_object('ok', false, 'error', 'not_authenticated');
  END IF;

  SELECT embers_signup_cost INTO v_cost FROM race_events WHERE id = p_event_id;
  IF v_cost IS NULL THEN
    RETURN jsonb_build_object('ok', false, 'error', 'event_not_found');
  END IF;

  SELECT embers_balance INTO v_bal FROM users WHERE id = v_user FOR UPDATE;
  IF v_bal IS NULL THEN
    RETURN jsonb_build_object('ok', false, 'error', 'user_not_found');
  END IF;

  IF v_bal < v_cost THEN
    RETURN jsonb_build_object('ok', false, 'error', 'insufficient_embers', 'required', v_cost, 'balance', v_bal);
  END IF;

  INSERT INTO user_event_registrations (user_id, event_id, embers_stake_paid)
  VALUES (v_user, p_event_id, v_cost);

  UPDATE users SET embers_balance = embers_balance - v_cost, updated_at = NOW() WHERE id = v_user;

  INSERT INTO ember_ledger (user_id, amount, balance_after, reason, ref_type, ref_id)
  VALUES (
    v_user,
    -v_cost,
    (SELECT embers_balance FROM users WHERE id = v_user),
    'event_signup',
    'race_event',
    p_event_id
  );

  RETURN jsonb_build_object('ok', true, 'embers_spent', v_cost);
EXCEPTION
  WHEN unique_violation THEN
    RETURN jsonb_build_object('ok', false, 'error', 'already_registered');
END;
$$;

-- ─── RPC: complete event from workout (medal + optional stake refund) ──────
CREATE OR REPLACE FUNCTION public.complete_event_challenge(
  p_event_id UUID,
  p_workout_id UUID
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_user UUID := auth.uid();
  v_reg RECORD;
  v_event RECORD;
  v_stake INTEGER;
BEGIN
  IF v_user IS NULL THEN
    RETURN jsonb_build_object('ok', false, 'error', 'not_authenticated');
  END IF;

  SELECT * INTO v_reg FROM user_event_registrations
  WHERE user_id = v_user AND event_id = p_event_id AND completed = false FOR UPDATE;
  IF NOT FOUND THEN
    RETURN jsonb_build_object('ok', false, 'error', 'not_registered_or_already_done');
  END IF;

  SELECT * INTO v_event FROM race_events WHERE id = p_event_id;
  IF NOT FOUND THEN
    RETURN jsonb_build_object('ok', false, 'error', 'event_not_found');
  END IF;

  IF EXISTS (SELECT 1 FROM user_medals WHERE user_id = v_user AND event_id = p_event_id) THEN
    RETURN jsonb_build_object('ok', false, 'error', 'medal_already_earned');
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM workouts w
    WHERE w.id = p_workout_id AND w.user_id = v_user
  ) THEN
    RETURN jsonb_build_object('ok', false, 'error', 'workout_not_owned');
  END IF;

  UPDATE user_event_registrations SET
    completed = true,
    completed_at = NOW(),
    linked_workout_id = p_workout_id,
    xp_awarded = true
  WHERE id = v_reg.id;

  INSERT INTO user_medals (user_id, event_id, workout_id, medal_title, medal_asset_key)
  VALUES (
    v_user,
    p_event_id,
    p_workout_id,
    COALESCE(v_event.medal_title, v_event.title),
    COALESCE(v_event.medal_asset_key, 'medal_default')
  );

  v_stake := v_reg.embers_stake_paid;
  IF v_stake > 0 AND NOT v_reg.stake_refunded THEN
    UPDATE users SET embers_balance = embers_balance + v_stake, updated_at = NOW() WHERE id = v_user;
    UPDATE user_event_registrations SET stake_refunded = true WHERE id = v_reg.id;
    INSERT INTO ember_ledger (user_id, amount, balance_after, reason, ref_type, ref_id)
    VALUES (
      v_user,
      v_stake,
      (SELECT embers_balance FROM users WHERE id = v_user),
      'event_stake_refund',
      'race_event',
      p_event_id
    );
  END IF;

  IF v_event.xp_reward > 0 THEN
    INSERT INTO xp_events (user_id, source, xp_amount, description, event_id, workout_id)
    VALUES (
      v_user,
      'event',
      v_event.xp_reward,
      'Reto completado: ' || v_event.title,
      p_event_id,
      p_workout_id
    );
    UPDATE users SET
      total_xp = total_xp + v_event.xp_reward,
      updated_at = NOW()
    WHERE id = v_user;
  END IF;

  RETURN jsonb_build_object('ok', true, 'xp', v_event.xp_reward, 'stake_refunded', v_stake > 0);
END;
$$;

-- ─── RPC: buy partner voucher ─────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.buy_partner_voucher(p_promotion_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_user UUID := auth.uid();
  v_promo RECORD;
  v_bal INTEGER;
  v_code TEXT;
  v_id UUID := uuid_generate_v4();
BEGIN
  IF v_user IS NULL THEN
    RETURN jsonb_build_object('ok', false, 'error', 'not_authenticated');
  END IF;

  SELECT * INTO v_promo FROM partner_promotions
  WHERE id = p_promotion_id AND active = true AND valid_until > NOW();
  IF NOT FOUND THEN
    RETURN jsonb_build_object('ok', false, 'error', 'promotion_invalid');
  END IF;

  SELECT embers_balance INTO v_bal FROM users WHERE id = v_user FOR UPDATE;
  IF v_bal < v_promo.embers_cost THEN
    RETURN jsonb_build_object('ok', false, 'error', 'insufficient_embers');
  END IF;

  v_code := upper(substring(replace(v_id::text, '-', ''), 1, 12));

  UPDATE users SET embers_balance = embers_balance - v_promo.embers_cost, updated_at = NOW() WHERE id = v_user;

  INSERT INTO ember_ledger (user_id, amount, balance_after, reason, ref_type, ref_id)
  VALUES (
    v_user,
    -v_promo.embers_cost,
    (SELECT embers_balance FROM users WHERE id = v_user),
    'partner_voucher',
    'partner_promotion',
    p_promotion_id
  );

  INSERT INTO user_partner_vouchers (id, user_id, promotion_id, redeem_code, qr_payload, expires_at)
  VALUES (
    v_id,
    v_user,
    p_promotion_id,
    v_code,
    'FYNIX:' || v_code || ':' || p_promotion_id::text,
    v_promo.valid_until
  );

  RETURN jsonb_build_object(
    'ok', true,
    'voucher_id', v_id,
    'redeem_code', v_code,
    'qr_payload', 'FYNIX:' || v_code || ':' || p_promotion_id::text,
    'expires_at', v_promo.valid_until
  );
END;
$$;

GRANT EXECUTE ON FUNCTION public.join_event_challenge(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.complete_event_challenge(UUID, UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.buy_partner_voucher(UUID) TO authenticated;

-- ─── RLS: new tables ─────────────────────────────────────────────────────────
ALTER TABLE user_medals ENABLE ROW LEVEL SECURITY;
ALTER TABLE ember_ledger ENABLE ROW LEVEL SECURITY;
ALTER TABLE partner_promotions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_partner_vouchers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_medals_select_own"
  ON user_medals FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "ember_ledger_select_own"
  ON ember_ledger FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "partner_promotions_select_active"
  ON partner_promotions FOR SELECT TO authenticated
  USING (active = true AND valid_until > NOW());

CREATE POLICY "user_vouchers_select_own"
  ON user_partner_vouchers FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

-- Service role inserts vouchers via RPC only; users do not insert directly
