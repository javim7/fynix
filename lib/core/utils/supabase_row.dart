import 'package:fynix/core/models/race_event.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/models/workout.dart';

/// Maps Postgres/PostgREST snake_case rows to app models (JSON serializers expect camelCase).
UserProfile userProfileFromSupabase(Map<String, dynamic> row) {
  return UserProfile(
    id: row['id'] as String,
    username: row['username'] as String,
    displayName: row['display_name'] as String,
    email: row['email'] as String,
    bio: row['bio'] as String?,
    avatarId: row['avatar_id'] as String? ?? 'default',
    city: row['city'] as String?,
    country: row['country'] as String? ?? 'GT',
    level: (row['level'] as num?)?.toInt() ?? 1,
    totalXp: (row['total_xp'] as num?)?.toInt() ?? 0,
    xpToNextLevel: (row['xp_to_next_level'] as num?)?.toInt() ?? 500,
    currentStreak: (row['current_streak'] as num?)?.toInt() ?? 0,
    longestStreak: (row['longest_streak'] as num?)?.toInt() ?? 0,
    lastActivityDate: row['last_activity_date'] == null
        ? null
        : DateTime.tryParse(row['last_activity_date'].toString()),
    streakFreezesRemaining:
        (row['streak_freezes_remaining'] as num?)?.toInt() ?? 0,
    followingCount: (row['following_count'] as num?)?.toInt() ?? 0,
    followerCount: (row['follower_count'] as num?)?.toInt() ?? 0,
    totalWorkouts: (row['total_workouts'] as num?)?.toInt() ?? 0,
    totalDistanceMeters: (row['total_distance_meters'] as num?)?.toInt() ?? 0,
    totalDurationSeconds: (row['total_duration_seconds'] as num?)?.toInt() ?? 0,
    subscriptionStatus: _parseSubStatus(row['subscription_status'] as String?),
    subscriptionTier: _parseSubTier(row['subscription_tier'] as String?),
    subscriptionExpiresAt: row['subscription_expires_at'] == null
        ? null
        : DateTime.tryParse(row['subscription_expires_at'] as String),
    revenuecatCustomerId: row['revenuecat_customer_id'] as String?,
    createdAt: DateTime.parse(row['created_at'] as String),
    updatedAt: DateTime.parse(row['updated_at'] as String),
    embersBalance: (row['embers_balance'] as num?)?.toInt() ?? 0,
  );
}

SubscriptionStatus _parseSubStatus(String? s) {
  switch (s) {
    case 'free':
      return SubscriptionStatus.free;
    case 'active':
      return SubscriptionStatus.active;
    case 'cancelled':
      return SubscriptionStatus.cancelled;
    case 'expired':
      return SubscriptionStatus.expired;
    case 'billing_issue':
      return SubscriptionStatus.billingIssue;
    default:
      return SubscriptionStatus.free;
  }
}

SubscriptionTier _parseSubTier(String? s) =>
    s == 'premium' ? SubscriptionTier.premium : SubscriptionTier.free;

WorkoutSportType _parseSportType(String? s) {
  switch (s) {
    case 'cycling':
      return WorkoutSportType.cycling;
    case 'swimming':
      return WorkoutSportType.swimming;
    case 'walking':
      return WorkoutSportType.walking;
    case 'hiking':
      return WorkoutSportType.hiking;
    case 'strength':
      return WorkoutSportType.strength;
    case 'yoga':
      return WorkoutSportType.yoga;
    case 'crossfit':
      return WorkoutSportType.crossfit;
    case 'triathlon':
      return WorkoutSportType.triathlon;
    default:
      return WorkoutSportType.running;
  }
}

IntegrationProvider? _parseIntegrationProvider(String? p) {
  switch (p) {
    case 'strava':
      return IntegrationProvider.strava;
    case 'garmin':
      return IntegrationProvider.garmin;
    case 'coros':
      return IntegrationProvider.coros;
    case 'apple_health':
      return IntegrationProvider.appleHealth;
    case 'google_fit':
      return IntegrationProvider.googleFit;
    default:
      return null;
  }
}

Workout workoutFromSupabase(Map<String, dynamic> row) {
  final splitsRaw = row['splits'];
  final splits = <WorkoutSplit>[];
  if (splitsRaw is List) {
    for (final e in splitsRaw) {
      if (e is Map<String, dynamic>) {
        splits.add(WorkoutSplit(
          distanceMeters: (e['distance_meters'] as num?)?.toDouble() ??
              (e['distanceMeters'] as num?)?.toDouble() ??
              0,
          durationSeconds: (e['duration_seconds'] as num?)?.toInt() ??
              (e['durationSeconds'] as num?)?.toInt() ??
              0,
          paceSecondsPerKm: (e['pace_seconds_per_km'] as num?)?.toDouble() ??
              (e['paceSecondsPerKm'] as num?)?.toDouble(),
        ));
      }
    }
  }

  final xpRaw = row['xp_breakdown'];
  XpBreakdownData? xpBreakdown;
  if (xpRaw is Map<String, dynamic>) {
    xpBreakdown = XpBreakdownData(
      baseXp: (xpRaw['base_xp'] as num?)?.toInt() ??
          (xpRaw['baseXp'] as num?)?.toInt() ??
          0,
      streakBonus: (xpRaw['streak_bonus'] as num?)?.toInt() ??
          (xpRaw['streakBonus'] as num?)?.toInt() ??
          0,
      prBonus: (xpRaw['pr_bonus'] as num?)?.toInt() ??
          (xpRaw['prBonus'] as num?)?.toInt() ??
          0,
      morningBonus: (xpRaw['morning_bonus'] as num?)?.toInt() ??
          (xpRaw['morningBonus'] as num?)?.toInt() ??
          0,
      challengeBonus: (xpRaw['challenge_bonus'] as num?)?.toInt() ??
          (xpRaw['challengeBonus'] as num?)?.toInt() ??
          0,
      eventBonus: (xpRaw['event_bonus'] as num?)?.toInt() ??
          (xpRaw['eventBonus'] as num?)?.toInt() ??
          0,
      total: (xpRaw['total'] as num?)?.toInt() ?? 0,
      ratePerKm: (xpRaw['rate_per_km'] as num?)?.toDouble() ??
          (xpRaw['ratePerKm'] as num?)?.toDouble(),
      distanceKm: (xpRaw['distance_km'] as num?)?.toDouble() ??
          (xpRaw['distanceKm'] as num?)?.toDouble(),
      sport: xpRaw['sport'] as String?,
    );
  }

  return Workout(
    id: row['id'] as String,
    userId: row['user_id'] as String,
    integrationId: row['integration_id'] as String?,
    provider: _parseIntegrationProvider(row['provider'] as String?),
    providerActivityId: row['provider_activity_id'] as String?,
    sportType: _parseSportType(row['sport_type'] as String?),
    name: row['name'] as String?,
    description: row['description'] as String?,
    startedAt: DateTime.parse(row['started_at'] as String),
    endedAt: row['ended_at'] == null
        ? null
        : DateTime.tryParse(row['ended_at'] as String),
    durationSeconds: (row['duration_seconds'] as num).toInt(),
    distanceMeters: (row['distance_meters'] as num?)?.toDouble() ?? 0,
    avgPaceSecondsPerKm:
        (row['avg_pace_seconds_per_km'] as num?)?.toDouble(),
    avgSpeedKmh: (row['avg_speed_kmh'] as num?)?.toDouble(),
    maxSpeedKmh: (row['max_speed_kmh'] as num?)?.toDouble(),
    elevationGainMeters:
        (row['elevation_gain_meters'] as num?)?.toDouble() ?? 0,
    elevationLossMeters:
        (row['elevation_loss_meters'] as num?)?.toDouble() ?? 0,
    avgHeartRate: (row['avg_heart_rate'] as num?)?.toInt(),
    maxHeartRate: (row['max_heart_rate'] as num?)?.toInt(),
    calories: (row['calories'] as num?)?.toInt(),
    polyline: row['polyline'] as String?,
    mapSnapshotUrl: row['map_snapshot_url'] as String?,
    splits: splits,
    xpEarned: (row['xp_earned'] as num?)?.toInt() ?? 0,
    xpBreakdown: xpBreakdown,
    isDuplicate: row['is_duplicate'] as bool? ?? false,
    createdAt: DateTime.parse(row['created_at'] as String),
    updatedAt: DateTime.parse(row['updated_at'] as String),
  );
}

RaceEvent raceEventFromSupabase(
  Map<String, dynamic> row, {
  Map<String, dynamic>? registration,
}) {
  final eventDateStr = row['event_date'];
  final eventDate = eventDateStr is String
      ? DateTime.parse(eventDateStr)
      : DateTime.parse((eventDateStr as DateTime).toIso8601String());

  DateTime? parseTs(dynamic v) {
    if (v == null) return null;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  final reg = registration;
  return RaceEvent(
    id: row['id'] as String,
    title: row['title'] as String,
    description: row['description'] as String?,
    sportType: _parseSportType(row['sport_type'] as String?),
    distanceMeters: (row['distance_meters'] as num?)?.toInt(),
    location: row['location'] as String?,
    city: row['city'] as String?,
    country: row['country'] as String? ?? 'GT',
    eventDate: eventDate,
    registrationUrl: row['registration_url'] as String?,
    imageUrl: row['image_url'] as String?,
    xpReward: (row['xp_reward'] as num?)?.toInt() ?? 0,
    bonusXpReward: (row['bonus_xp_reward'] as num?)?.toInt() ?? 0,
    isFeatured: row['is_featured'] as bool? ?? false,
    createdAt: DateTime.parse(row['created_at'] as String),
    isRegistered: reg != null,
    isCompleted: reg != null && (reg['completed'] as bool? ?? false),
    registeredAt:
        reg == null ? null : DateTime.tryParse(reg['registered_at'] as String),
    completedAt:
        reg == null || reg['completed_at'] == null
            ? null
            : DateTime.tryParse(reg['completed_at'] as String),
    finishTimeSeconds: reg == null
        ? null
        : (reg['finish_time_seconds'] as num?)?.toInt(),
    matchWindowStart: parseTs(row['match_window_start']),
    matchWindowEnd: parseTs(row['match_window_end']),
    venueLat: (row['venue_lat'] as num?)?.toDouble(),
    venueLng: (row['venue_lng'] as num?)?.toDouble(),
    matchRadiusMeters: (row['match_radius_meters'] as num?)?.toInt() ?? 25000,
    embersSignupCost: (row['embers_signup_cost'] as num?)?.toInt() ?? 0,
    medalTitle: row['medal_title'] as String?,
    medalAssetKey: row['medal_asset_key'] as String?,
    isSimulation: row['is_simulation'] as bool? ?? true,
    distanceTolerancePercent:
        (row['distance_tolerance_percent'] as num?)?.toDouble() ?? 8.0,
  );
}
