import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fynix/core/models/workout.dart';

part 'race_event.freezed.dart';
part 'race_event.g.dart';

/// A race or community event — mirrors the `race_events` table.
@freezed
abstract class RaceEvent with _$RaceEvent {
  const factory RaceEvent({
    required String id,
    required String title,
    String? description,
    @Default(WorkoutSportType.running) WorkoutSportType sportType,
    int? distanceMeters,
    String? location,
    String? city,
    @Default('GT') String country,
    required DateTime eventDate,
    String? registrationUrl,
    String? imageUrl,
    @Default(0) int xpReward,
    @Default(0) int bonusXpReward,
    @Default(false) bool isFeatured,
    required DateTime createdAt,

    // User registration state (joined)
    @Default(false) bool isRegistered,
    @Default(false) bool isCompleted,
    DateTime? registeredAt,
    DateTime? completedAt,
    int? finishTimeSeconds,

    /// Activity must start within [matchWindowStart]..[matchWindowEnd] (UTC).
    DateTime? matchWindowStart,
    DateTime? matchWindowEnd,

    /// Event venue for GPS check (optional if null, geo rule skipped).
    double? venueLat,
    double? venueLng,

    /// Max distance in meters from activity start to venue (default 25 km).
    @Default(25000) int matchRadiusMeters,

    /// Embers deducted on join (refunded on completion via RPC when configured).
    @Default(0) int embersSignupCost,

    String? medalTitle,
    String? medalAssetKey,

    @Default(true) bool isSimulation,

    /// Allowed deviation from target distance (percent), e.g. 8 = ±8%.
    @Default(8.0) double distanceTolerancePercent,
  }) = _RaceEvent;

  factory RaceEvent.fromJson(Map<String, dynamic> json) =>
      _$RaceEventFromJson(json);
}
