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
  }) = _RaceEvent;

  factory RaceEvent.fromJson(Map<String, dynamic> json) =>
      _$RaceEventFromJson(json);
}
