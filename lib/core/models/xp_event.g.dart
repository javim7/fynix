// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$XpEventImpl _$$XpEventImplFromJson(Map<String, dynamic> json) =>
    _$XpEventImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      source: $enumDecode(_$XpSourceEnumMap, json['source']),
      xpAmount: (json['xpAmount'] as num).toInt(),
      description: json['description'] as String,
      workoutId: json['workoutId'] as String?,
      challengeId: json['challengeId'] as String?,
      badgeId: json['badgeId'] as String?,
      eventId: json['eventId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$XpEventImplToJson(_$XpEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'source': _$XpSourceEnumMap[instance.source]!,
      'xpAmount': instance.xpAmount,
      'description': instance.description,
      'workoutId': instance.workoutId,
      'challengeId': instance.challengeId,
      'badgeId': instance.badgeId,
      'eventId': instance.eventId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$XpSourceEnumMap = {
  XpSource.workout: 'workout',
  XpSource.challenge: 'challenge',
  XpSource.badge: 'badge',
  XpSource.event: 'event',
  XpSource.streakBonus: 'streakBonus',
  XpSource.manual: 'manual',
};
