// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingPlanWorkoutImpl _$$TrainingPlanWorkoutImplFromJson(
        Map<String, dynamic> json) =>
    _$TrainingPlanWorkoutImpl(
      id: json['id'] as String,
      weekId: json['weekId'] as String,
      dayNumber: (json['dayNumber'] as num).toInt(),
      workoutType: json['workoutType'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      targetDistanceMeters: (json['targetDistanceMeters'] as num?)?.toInt(),
      targetDurationSeconds: (json['targetDurationSeconds'] as num?)?.toInt(),
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$$TrainingPlanWorkoutImplToJson(
        _$TrainingPlanWorkoutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekId': instance.weekId,
      'dayNumber': instance.dayNumber,
      'workoutType': instance.workoutType,
      'title': instance.title,
      'description': instance.description,
      'targetDistanceMeters': instance.targetDistanceMeters,
      'targetDurationSeconds': instance.targetDurationSeconds,
      'instructions': instance.instructions,
    };

_$TrainingPlanWeekImpl _$$TrainingPlanWeekImplFromJson(
        Map<String, dynamic> json) =>
    _$TrainingPlanWeekImpl(
      id: json['id'] as String,
      planId: json['planId'] as String,
      weekNumber: (json['weekNumber'] as num).toInt(),
      focus: json['focus'] as String,
      description: json['description'] as String?,
      workouts: (json['workouts'] as List<dynamic>?)
              ?.map((e) =>
                  TrainingPlanWorkout.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TrainingPlanWeekImplToJson(
        _$TrainingPlanWeekImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planId': instance.planId,
      'weekNumber': instance.weekNumber,
      'focus': instance.focus,
      'description': instance.description,
      'workouts': instance.workouts,
    };

_$TrainingPlanImpl _$$TrainingPlanImplFromJson(Map<String, dynamic> json) =>
    _$TrainingPlanImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      sportType:
          $enumDecodeNullable(_$WorkoutSportTypeEnumMap, json['sportType']) ??
              WorkoutSportType.running,
      targetDistance: json['targetDistance'] as String,
      level: json['level'] as String,
      durationWeeks: (json['durationWeeks'] as num).toInt(),
      description: json['description'] as String?,
      isPremium: json['isPremium'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      weeks: (json['weeks'] as List<dynamic>?)
              ?.map((e) => TrainingPlanWeek.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? false,
      currentWeek: (json['currentWeek'] as num?)?.toInt(),
      currentDay: (json['currentDay'] as num?)?.toInt(),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
    );

Map<String, dynamic> _$$TrainingPlanImplToJson(_$TrainingPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sportType': _$WorkoutSportTypeEnumMap[instance.sportType]!,
      'targetDistance': instance.targetDistance,
      'level': instance.level,
      'durationWeeks': instance.durationWeeks,
      'description': instance.description,
      'isPremium': instance.isPremium,
      'createdAt': instance.createdAt.toIso8601String(),
      'weeks': instance.weeks,
      'isActive': instance.isActive,
      'currentWeek': instance.currentWeek,
      'currentDay': instance.currentDay,
      'startedAt': instance.startedAt?.toIso8601String(),
    };

const _$WorkoutSportTypeEnumMap = {
  WorkoutSportType.running: 'running',
  WorkoutSportType.cycling: 'cycling',
  WorkoutSportType.swimming: 'swimming',
  WorkoutSportType.walking: 'walking',
  WorkoutSportType.hiking: 'hiking',
  WorkoutSportType.strength: 'strength',
  WorkoutSportType.yoga: 'yoga',
  WorkoutSportType.crossfit: 'crossfit',
  WorkoutSportType.triathlon: 'triathlon',
  WorkoutSportType.other: 'other',
};
