import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

/// Sport types matching the database enum.
enum WorkoutSportType {
  running,
  cycling,
  swimming,
  walking,
  hiking,
  strength,
  yoga,
  crossfit,
  triathlon,
  other,
}

/// Integration provider matching the database enum.
enum IntegrationProvider {
  appleHealth,
  googleFit,
  strava,
  garmin,
  coros,
}

/// A single workout split (e.g. per-km split).
@freezed
abstract class WorkoutSplit with _$WorkoutSplit {
  const factory WorkoutSplit({
    required double distanceMeters,
    required int durationSeconds,
    double? paceSecondsPerKm,
  }) = _WorkoutSplit;

  factory WorkoutSplit.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSplitFromJson(json);
}

/// XP breakdown stored with each workout.
@freezed
abstract class XpBreakdownData with _$XpBreakdownData {
  const factory XpBreakdownData({
    required int baseXp,
    @Default(0) int streakBonus,
    @Default(0) int prBonus,
    @Default(0) int morningBonus,
    @Default(0) int challengeBonus,
    @Default(0) int eventBonus,
    required int total,
    double? ratePerKm,
    double? distanceKm,
    String? sport,
  }) = _XpBreakdownData;

  factory XpBreakdownData.fromJson(Map<String, dynamic> json) =>
      _$XpBreakdownDataFromJson(json);
}

/// Core workout model — mirrors the `workouts` table.
@freezed
abstract class Workout with _$Workout {
  const factory Workout({
    required String id,
    required String userId,
    String? integrationId,
    IntegrationProvider? provider,
    String? providerActivityId,
    required WorkoutSportType sportType,
    String? name,
    String? description,
    required DateTime startedAt,
    DateTime? endedAt,
    required int durationSeconds,
    @Default(0) double distanceMeters,
    double? avgPaceSecondsPerKm,
    double? avgSpeedKmh,
    double? maxSpeedKmh,
    @Default(0) double elevationGainMeters,
    @Default(0) double elevationLossMeters,
    int? avgHeartRate,
    int? maxHeartRate,
    int? calories,
    String? polyline,
    String? mapSnapshotUrl,
    @Default([]) List<WorkoutSplit> splits,
    @Default(0) int xpEarned,
    XpBreakdownData? xpBreakdown,
    @Default(false) bool isDuplicate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
}
