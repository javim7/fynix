# Fynix

Gamified multi-sport fitness app for Guatemala and Latin America. Built with Flutter + Supabase.

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile | Flutter 3.x (iOS + Android) |
| State | Riverpod + riverpod_generator |
| Navigation | GoRouter (StatefulShellRoute) |
| Backend | Supabase (PostgreSQL, Auth, Storage, Realtime) |
| Edge Functions | Deno / TypeScript |
| Subscriptions | RevenueCat |
| Maps | Mapbox Maps SDK |
| Health | Apple HealthKit + Google Fit (health package) |

## Prerequisites

- Flutter SDK ≥ 3.19 (`flutter --version`)
- Dart ≥ 3.0
- Supabase CLI (`brew install supabase/tap/supabase`)
- A Supabase project
- A RevenueCat account with products configured
- A Mapbox account

## Setup

### 1. Clone and install dependencies

```bash
git clone https://github.com/your-org/fynix.git
cd fynix
cp .env.example .env
flutter pub get
```

Fill in `.env` with your actual credentials.

### 2. Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates all `.g.dart` (Riverpod, JSON) and `.freezed.dart` (model) files.

### 3. Initialize Supabase

```bash
supabase login
supabase link --project-ref <your-project-ref>
supabase db push
```

This applies all three migrations in order:
- `001_initial_schema.sql` — tables, indexes, triggers
- `002_rls_policies.sql` — row-level security
- `003_seed_data.sql` — badges, skins, training plans, race events

### 4. Deploy Edge Functions

```bash
supabase functions deploy xp-calculator
supabase functions deploy strava-webhook
supabase functions deploy revenuecat-webhook
supabase functions deploy streak-evaluator
supabase functions deploy badge-checker
supabase functions deploy leaderboard-refresh
supabase functions deploy health-sync
supabase functions deploy garmin-webhook
```

Set function secrets:
```bash
supabase secrets set SUPABASE_SERVICE_ROLE_KEY=<your-service-role-key>
supabase secrets set STRAVA_CLIENT_ID=<id>
supabase secrets set STRAVA_CLIENT_SECRET=<secret>
supabase secrets set REVENUECAT_WEBHOOK_SECRET=<secret>
```

### 5. Run the app

```bash
flutter run
```

## Architecture

```
lib/
├── app/               # Router, theme, app root
├── core/
│   ├── constants/     # Colors, typography, spacing
│   ├── models/        # Freezed domain models
│   ├── services/      # Health, Strava, connectivity
│   ├── utils/         # XP calculator, formatters
│   └── widgets/       # Shared UI components
└── features/
    ├── auth/
    ├── dashboard/
    ├── workouts/
    ├── integrations/
    ├── feed/
    ├── social/
    ├── gamification/
    ├── events/
    ├── training/
    ├── profile/
    ├── avatar/
    └── subscription/
```

Each feature follows the same three-layer pattern:
- `data/` — repository (Supabase queries)
- `domain/` — Riverpod notifier + state
- `presentation/` — screens

## XP System

- **Running**: 10 XP/km | **Swimming**: 30 XP/km | **Cycling**: 4 XP/km
- **Walking**: 5 XP/km | **Hiking**: 8 XP/km
- **Strength**: 90 XP/hr | **Yoga**: 80 XP/hr | **CrossFit**: 100 XP/hr
- Streak bonuses: 7d +10%, 14d +20%, 30d +30%, 90d +50%
- PR bonus: fastest pace +50 XP, longest distance +30 XP
- Morning bonus (5:00–6:59): +5 XP
- Level formula: `cumulative_xp(N) = floor(400 × N^1.5)` for N ≥ 2

XP is written server-side via the `xp-calculator` Edge Function. Flutter shows estimates only.

## Subscription

Two tiers via RevenueCat:
- **Free** — core workout logging, basic stats, 5 avatar skins
- **Premium** — unlimited device connections, training plans, advanced analytics, 30+ skins, streak freezes, exclusive missions

Product IDs: `fynix_premium_monthly`, `fynix_premium_annual`
Entitlement ID: `premium`

## Testing

```bash
flutter test
```

Key unit tests:
- `test/unit/xp_calculator_test.dart` — all sport rates, bonuses, level system
- `test/unit/streak_logic_test.dart` — date helpers and streak lifecycle
- `test/unit/pace_formatter_test.dart` — all formatter outputs
- `test/widget/fynix_button_test.dart` — button variants, states
- `test/widget/xp_bar_test.dart` — XP bar and XpBurst rendering

## Environment Variables

See `.env.example` for all required keys. Never commit `.env`.

## Phase 2 (Planned)

- Garmin Connect IQ full integration
- COROS full integration
- Live activity tracking (GPS)
- AI-powered training plan generation
- Push notifications (streak reminders, badge unlocks)
