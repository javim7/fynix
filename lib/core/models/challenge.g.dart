// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: json['id'] as String,
      challengeType: $enumDecode(_$ChallengeTypeEnumMap, json['challengeType']),
      title: json['title'] as String,
      description: json['description'] as String?,
      sportType:
          $enumDecodeNullable(_$WorkoutSportTypeEnumMap, json['sportType']),
      targetValue: (json['targetValue'] as num).toDouble(),
      targetUnit: json['targetUnit'] as String,
      xpReward: (json['xpReward'] as num).toInt(),
      isDaily: json['isDaily'] as bool? ?? true,
      isPremium: json['isPremium'] as bool? ?? false,
      icon: json['icon'] as String?,
      startsAt: json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      progressValue: (json['progressValue'] as num?)?.toDouble() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengeType': _$ChallengeTypeEnumMap[instance.challengeType]!,
      'title': instance.title,
      'description': instance.description,
      'sportType': _$WorkoutSportTypeEnumMap[instance.sportType],
      'targetValue': instance.targetValue,
      'targetUnit': instance.targetUnit,
      'xpReward': instance.xpReward,
      'isDaily': instance.isDaily,
      'isPremium': instance.isPremium,
      'icon': instance.icon,
      'startsAt': instance.startsAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'progressValue': instance.progressValue,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$ChallengeTypeEnumMap = {
  ChallengeType.distance: 'distance',
  ChallengeType.duration: 'duration',
  ChallengeType.frequency: 'frequency',
  ChallengeType.streak: 'streak',
  ChallengeType.sportSpecific: 'sportSpecific',
  ChallengeType.event: 'event',
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
