-- ─────────────────────────────────────────────────────────────────────────────
-- Fynix — Seed Data
-- Migration: 003_seed_data.sql
-- ─────────────────────────────────────────────────────────────────────────────

-- ─── AVATAR SKINS ─────────────────────────────────────────────────────────────
INSERT INTO avatar_skins (name, asset_path, level_required, is_premium, sort_order) VALUES
  ('Corredor Base',     'avatars/runner_base.png',     1,  false, 1),
  ('Ciclista Base',     'avatars/cyclist_base.png',    1,  false, 2),
  ('Nadador Base',      'avatars/swimmer_base.png',    1,  false, 3),
  ('Caminante Base',    'avatars/walker_base.png',     1,  false, 4),
  ('Atleta Base',       'avatars/athlete_base.png',    1,  false, 5),
  -- Premium skins (level-gated)
  ('Corredor Dorado',   'avatars/runner_gold.png',     10, true,  10),
  ('Ciclista Dorado',   'avatars/cyclist_gold.png',    10, true,  11),
  ('Guerrero de Fuego', 'avatars/fire_warrior.png',    20, true,  20),
  ('Élite Fynix',       'avatars/fynix_elite.png',     50, true,  50);

-- ─── BADGES ───────────────────────────────────────────────────────────────────
INSERT INTO badges (title, description, icon_asset, condition_type, condition_sport, condition_value, xp_reward, is_premium, sort_order) VALUES
  -- Distance badges (running)
  ('Primera Carrera',       'Completa tu primera carrera',           'badges/first_run.png',    'total_workouts', 'running', 1,     0,   false, 1),
  ('5K Club',               'Corre 5 km en una sola actividad',      'badges/5k.png',           'distance',       'running', 5000,  50,  false, 2),
  ('10K Finisher',          'Corre 10 km en una sola actividad',     'badges/10k.png',          'distance',       'running', 10000, 100, false, 3),
  ('21K Finisher',          'Corre una media maratón',               'badges/21k.png',          'distance',       'running', 21097, 200, false, 4),
  ('Maratonista',           'Corre una maratón completa',            'badges/marathon.png',     'distance',       'running', 42195, 500, true,  5),
  ('100K Runner',           'Corre 100 km en total',                 'badges/100k_total.png',   'total_distance', 'running', 100000, 150, false, 6),
  ('500K Runner',           'Corre 500 km en total',                 'badges/500k_total.png',   'total_distance', 'running', 500000, 400, true,  7),
  -- Streak badges
  ('Semana Perfecta',       'Mantén una racha de 7 días',            'badges/streak_7.png',     'streak',         NULL,      7,     75,  false, 20),
  ('Racha de Fuego',        'Mantén una racha de 30 días',           'badges/streak_30.png',    'streak',         NULL,      30,    300, false, 21),
  ('Imparable',             'Mantén una racha de 90 días',           'badges/streak_90.png',    'streak',         NULL,      90,    750, true,  22),
  -- Level badges
  ('Nivel 10',              'Alcanza el nivel 10',                   'badges/level_10.png',     'level',          NULL,      10,    100, false, 30),
  ('Nivel 25',              'Alcanza el nivel 25',                   'badges/level_25.png',     'level',          NULL,      25,    250, true,  31),
  ('Nivel 50',              'Alcanza el nivel 50',                   'badges/level_50.png',     'level',          NULL,      50,    500, true,  32),
  -- Cross-sport badges
  ('Multi-Deporte',         'Registra 3 deportes diferentes',        'badges/multisport.png',   'sport_variety',  NULL,      3,     100, false, 40),
  ('Ciclista del Altiplano','Pedalea 200 km en total',               'badges/cyclist_200k.png', 'total_distance', 'cycling', 200000, 150, false, 41),
  ('Nadador del Lago',      'Nada 10 km en total',                   'badges/swimmer_10k.png',  'total_distance', 'swimming', 10000, 150, false, 42);

-- ─── DAILY CHALLENGES ─────────────────────────────────────────────────────────
-- Note: daily challenges are auto-refreshed by the backend.
-- These are templates that the streak-evaluator seeds each day.
INSERT INTO challenges (challenge_type, title, description, sport_type, target_value, target_unit, xp_reward, is_daily, is_premium, icon) VALUES
  ('distance',       'Corre 5K hoy',              'Completa una carrera de al menos 5 km',        'running',  5,    'km',       50,  true, 'challenge_run'),
  ('distance',       'Corre 10K hoy',             'Completa una carrera de al menos 10 km',       'running',  10,   'km',       100, true, 'challenge_run_long'),
  ('distance',       'Pedalea 20K hoy',           'Completa un paseo en bici de al menos 20 km',  'cycling',  20,   'km',       60,  true, 'challenge_bike'),
  ('duration',       'Entrena 30 minutos',         'Cualquier deporte durante al menos 30 min',    NULL,       30,   'minutes',  40,  true, 'challenge_timer'),
  ('duration',       'Entrena 1 hora',             'Cualquier deporte durante al menos 60 min',    NULL,       60,   'minutes',  80,  true, 'challenge_timer_long'),
  ('duration',       'Yoga o fuerza hoy',          'Haz 45 minutos de yoga o fuerza',             NULL,       45,   'minutes',  50,  true, 'challenge_yoga'),
  ('frequency',      'Triple entrenamiento',       'Completa 3 actividades esta semana',           NULL,       3,    'workouts', 120, true, 'challenge_multi'),
  ('distance',       'Caminata de 3K',            'Camina al menos 3 km hoy',                     'walking',  3,    'km',       30,  true, 'challenge_walk'),
  ('sport_specific', 'Senderismo del fin de semana','Completa una caminata de senderismo',         'hiking',   1,    'workouts', 70,  true, 'challenge_hike'),
  ('distance',       'Nada 1K',                   'Nada al menos 1 km en la piscina',             'swimming', 1,    'km',       90,  true, 'challenge_swim');

-- ─── TRAINING PLANS ───────────────────────────────────────────────────────────
DO $$
DECLARE
  plan_5k_beg   UUID;
  plan_5k_int   UUID;
  plan_10k_beg  UUID;
  plan_10k_int  UUID;
  plan_21k_beg  UUID;
  plan_21k_int  UUID;
  week_id       UUID;
BEGIN

  -- ── 5K Beginner (6 weeks) ────────────────────────────────────────────────
  INSERT INTO training_plans (title, sport_type, target_distance, level, duration_weeks, description, is_premium)
  VALUES ('5K para Principiantes', 'running', '5k', 'beginner', 6,
          'Plan de 6 semanas para completar tu primer 5K. Mezcla de carrera y caminata progresiva.', true)
  RETURNING id INTO plan_5k_beg;

  -- Week 1
  INSERT INTO training_plan_weeks (plan_id, week_number, focus, description) VALUES
    (plan_5k_beg, 1, 'Fundamentos', 'Activa tu cuerpo con intervalos suaves de carrera y caminata.')
  RETURNING id INTO week_id;
  INSERT INTO training_plan_workouts (week_id, day_number, workout_type, title, description, target_duration_seconds) VALUES
    (week_id, 1, 'easy_run',    'Carrera fácil 20 min',   'Alterna 1 min corriendo / 2 min caminando', 1200),
    (week_id, 2, 'rest',        'Descanso activo',         'Camina o estira suavemente', NULL),
    (week_id, 3, 'easy_run',    'Carrera fácil 20 min',   'Alterna 1 min corriendo / 2 min caminando', 1200),
    (week_id, 4, 'rest',        'Descanso',                NULL, NULL),
    (week_id, 5, 'easy_run',    'Carrera fácil 25 min',   'Alterna 2 min corriendo / 2 min caminando', 1500),
    (week_id, 6, 'cross_train', 'Entrenamiento cruzado',  'Bicicleta o natación 30 min', 1800),
    (week_id, 7, 'rest',        'Descanso',                NULL, NULL);

  -- ── 5K Intermediate (8 weeks) ────────────────────────────────────────────
  INSERT INTO training_plans (title, sport_type, target_distance, level, duration_weeks, description, is_premium)
  VALUES ('5K Intermedio — Mejora tu marca', 'running', '5k', 'intermediate', 8,
          'Plan de 8 semanas para bajar tu marca en 5K con trabajo de velocidad.', true)
  RETURNING id INTO plan_5k_int;

  INSERT INTO training_plan_weeks (plan_id, week_number, focus, description) VALUES
    (plan_5k_int, 1, 'Base de velocidad', 'Establece tu ritmo base con carrera continua.')
  RETURNING id INTO week_id;
  INSERT INTO training_plan_workouts (week_id, day_number, workout_type, title, description, target_distance_meters, target_duration_seconds) VALUES
    (week_id, 1, 'easy_run',  'Carrera suave 5K',     'Ritmo conversacional', 5000, NULL),
    (week_id, 2, 'rest',      'Descanso',              NULL, NULL, NULL),
    (week_id, 3, 'interval',  'Intervalos 6x400m',     '6 repeticiones de 400m al 90% esfuerzo, recuperación de 90s', NULL, NULL),
    (week_id, 4, 'easy_run',  'Carrera recuperación',  'Ritmo muy suave 30 min', NULL, 1800),
    (week_id, 5, 'interval',  'Tempo Run 20 min',      'Ritmo de umbral anaeróbico sostenido', NULL, 1200),
    (week_id, 6, 'long_run',  'Carrera larga 8K',      'Ritmo cómodo', 8000, NULL),
    (week_id, 7, 'rest',      'Descanso activo',        NULL, NULL, NULL);

  -- ── 10K Beginner (8 weeks) ───────────────────────────────────────────────
  INSERT INTO training_plans (title, sport_type, target_distance, level, duration_weeks, description, is_premium)
  VALUES ('10K para Principiantes', 'running', '10k', 'beginner', 8,
          'Plan de 8 semanas para completar tu primer 10K a paso cómodo.', true)
  RETURNING id INTO plan_10k_beg;

  INSERT INTO training_plan_weeks (plan_id, week_number, focus, description) VALUES
    (plan_10k_beg, 1, 'Construcción de base', 'Aumenta tu volumen de carrera gradualmente.')
  RETURNING id INTO week_id;
  INSERT INTO training_plan_workouts (week_id, day_number, workout_type, title, description, target_distance_meters) VALUES
    (week_id, 1, 'easy_run',  'Carrera fácil 4K',   'Ritmo suave', 4000),
    (week_id, 2, 'rest',      'Descanso',            NULL, NULL),
    (week_id, 3, 'easy_run',  'Carrera fácil 4K',   'Ritmo suave', 4000),
    (week_id, 4, 'cross_train','Bicicleta 30 min',   'Entrenamiento cruzado', NULL),
    (week_id, 5, 'easy_run',  'Carrera fácil 5K',   'Ritmo suave', 5000),
    (week_id, 6, 'long_run',  'Carrera larga 6K',   'Ritmo muy cómodo', 6000),
    (week_id, 7, 'rest',      'Descanso',            NULL, NULL);

  -- ── 10K Intermediate (10 weeks) ──────────────────────────────────────────
  INSERT INTO training_plans (title, sport_type, target_distance, level, duration_weeks, description, is_premium)
  VALUES ('10K Intermedio — Sub 55 min', 'running', '10k', 'intermediate', 10,
          'Plan de 10 semanas para correr 10K en menos de 55 minutos.', true)
  RETURNING id INTO plan_10k_int;

  INSERT INTO training_plan_weeks (plan_id, week_number, focus, description) VALUES
    (plan_10k_int, 1, 'Evaluación y base', 'Test de 5K y construcción de base aeróbica.')
  RETURNING id INTO week_id;
  INSERT INTO training_plan_workouts (week_id, day_number, workout_type, title, description, target_distance_meters) VALUES
    (week_id, 1, 'easy_run',  'Test 5K',             'Corre 5K a tu mejor ritmo actual para evaluar tu forma', 5000),
    (week_id, 2, 'rest',      'Descanso',             NULL, NULL),
    (week_id, 3, 'easy_run',  'Carrera fácil 6K',    'Ritmo suave de recuperación', 6000),
    (week_id, 4, 'interval',  'Fartlek 30 min',      'Alterna ritmos durante 30 min', NULL),
    (week_id, 5, 'easy_run',  'Carrera fácil 5K',    'Ritmo conversacional', 5000),
    (week_id, 6, 'long_run',  'Carrera larga 10K',   'Ritmo muy cómodo', 10000),
    (week_id, 7, 'rest',      'Descanso activo',      NULL, NULL);

  -- ── 21K Beginner (12 weeks) ──────────────────────────────────────────────
  INSERT INTO training_plans (title, sport_type, target_distance, level, duration_weeks, description, is_premium)
  VALUES ('21K para Principiantes', 'running', '21k', 'beginner', 12,
          'Plan de 12 semanas para completar tu primera media maratón y cruzar la meta.', true)
  RETURNING id INTO plan_21k_beg;

  INSERT INTO training_plan_weeks (plan_id, week_number, focus, description) VALUES
    (plan_21k_beg, 1, 'Base aeróbica', 'Construye resistencia con carreras suaves.')
  RETURNING id INTO week_id;
  INSERT INTO training_plan_workouts (week_id, day_number, workout_type, title, description, target_distance_meters) VALUES
    (week_id, 1, 'easy_run',  'Carrera fácil 5K',    'Ritmo muy suave', 5000),
    (week_id, 2, 'rest',      'Descanso',             NULL, NULL),
    (week_id, 3, 'easy_run',  'Carrera fácil 5K',    'Ritmo suave', 5000),
    (week_id, 4, 'cross_train','Natación o bici 40 min','Entrenamiento cruzado', NULL),
    (week_id, 5, 'easy_run',  'Carrera fácil 6K',    'Ritmo conversacional', 6000),
    (week_id, 6, 'long_run',  'Carrera larga 8K',    'Ritmo de final de carrera', 8000),
    (week_id, 7, 'rest',      'Descanso completo',    NULL, NULL);

  -- ── 21K Intermediate (14 weeks) ──────────────────────────────────────────
  INSERT INTO training_plans (title, sport_type, target_distance, level, duration_weeks, description, is_premium)
  VALUES ('21K Intermedio — Sub 2h', 'running', '21k', 'intermediate', 14,
          'Plan de 14 semanas para correr una media maratón en menos de 2 horas.', true)
  RETURNING id INTO plan_21k_int;

  INSERT INTO training_plan_weeks (plan_id, week_number, focus, description) VALUES
    (plan_21k_int, 1, 'Evaluación inicial', 'Test de 10K y semana de base.')
  RETURNING id INTO week_id;
  INSERT INTO training_plan_workouts (week_id, day_number, workout_type, title, description, target_distance_meters) VALUES
    (week_id, 1, 'easy_run',  'Test 10K',            'Corre 10K a tu ritmo actual', 10000),
    (week_id, 2, 'rest',      'Descanso',             NULL, NULL),
    (week_id, 3, 'easy_run',  'Carrera fácil 8K',    'Recuperación activa', 8000),
    (week_id, 4, 'interval',  'Intervalos 8x400m',   '8 repeticiones de 400m al 90%, recuperación 90s', NULL),
    (week_id, 5, 'easy_run',  'Carrera tempo 6K',    'Ritmo de umbral', 6000),
    (week_id, 6, 'long_run',  'Carrera larga 15K',   'Ritmo de media maratón objetivo', 15000),
    (week_id, 7, 'rest',      'Descanso activo',      NULL, NULL);

END $$;

-- ─── RACE EVENTS — Sample Data ────────────────────────────────────────────────
INSERT INTO race_events (title, description, sport_type, distance_meters, location, city, country, event_date, xp_reward, bonus_xp_reward, is_featured) VALUES
  ('21K de Cobán 2026',         'La carrera más emblemática de Guatemala entre nubes y neblina.',
   'running', 21097, 'Cobán, Alta Verapaz', 'Cobán', 'GT', '2026-06-07', 500, 200, true),
  ('5K Parque las Naciones',    'Carrera familiar nocturna en Ciudad de Guatemala.',
   'running', 5000, 'Parque Las Naciones Unidas', 'Guatemala City', 'GT', '2026-04-19', 100, 50, false),
  ('10K Volcán de Agua',        'Carrera de montaña con vistas al Volcán de Agua.',
   'running', 10000, 'Antigua Guatemala', 'Antigua', 'GT', '2026-05-10', 250, 100, true),
  ('Maratón de Guatemala 2026', 'La maratón nacional. 42K por las calles de la capital.',
   'running', 42195, 'Ciudad de Guatemala', 'Guatemala City', 'GT', '2026-08-30', 1000, 500, true),
  ('Gran Fondo Ciclista GT',    'Ciclopaseo de 80 km por el altiplano guatemalteco.',
   'cycling', 80000, 'Chimaltenango', 'Chimaltenango', 'GT', '2026-07-12', 400, 150, false);
