import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fynix/core/models/workout.dart';

part 'training_plan.freezed.dart';
part 'training_plan.g.dart';

/// A single scheduled workout inside a training plan week.
@freezed
abstract class TrainingPlanWorkout with _$TrainingPlanWorkout {
  const factory TrainingPlanWorkout({
    required String id,
    required String weekId,
    required int dayNumber,
    required String workoutType,
    required String title,
    String? description,
    int? targetDistanceMeters,
    int? targetDurationSeconds,
    String? instructions,
  }) = _TrainingPlanWorkout;

  factory TrainingPlanWorkout.fromJson(Map<String, dynamic> json) =>
      _$TrainingPlanWorkoutFromJson(json);
}

/// A single week inside a training plan.
@freezed
abstract class TrainingPlanWeek with _$TrainingPlanWeek {
  const factory TrainingPlanWeek({
    required String id,
    required String planId,
    required int weekNumber,
    required String focus,
    String? description,
    @Default([]) List<TrainingPlanWorkout> workouts,
  }) = _TrainingPlanWeek;

  factory TrainingPlanWeek.fromJson(Map<String, dynamic> json) =>
      _$TrainingPlanWeekFromJson(json);
}

/// A structured training plan — mirrors the `training_plans` table.
@freezed
abstract class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({
    required String id,
    required String title,
    @Default(WorkoutSportType.running) WorkoutSportType sportType,
    required String targetDistance,
    required String level,
    required int durationWeeks,
    String? description,
    @Default(true) bool isPremium,
    required DateTime createdAt,
    @Default([]) List<TrainingPlanWeek> weeks,

    // Active plan state (joined from user_active_plans)
    @Default(false) bool isActive,
    int? currentWeek,
    int? currentDay,
    DateTime? startedAt,
  }) = _TrainingPlan;

  factory TrainingPlan.fromJson(Map<String, dynamic> json) =>
      _$TrainingPlanFromJson(json);
}
