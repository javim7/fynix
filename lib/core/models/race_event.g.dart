// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RaceEventImpl _$$RaceEventImplFromJson(Map<String, dynamic> json) =>
    _$RaceEventImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      sportType:
          $enumDecodeNullable(_$WorkoutSportTypeEnumMap, json['sportType']) ??
              WorkoutSportType.running,
      distanceMeters: (json['distanceMeters'] as num?)?.toInt(),
      location: json['location'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String? ?? 'GT',
      eventDate: DateTime.parse(json['eventDate'] as String),
      registrationUrl: json['registrationUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      xpReward: (json['xpReward'] as num?)?.toInt() ?? 0,
      bonusXpReward: (json['bonusXpReward'] as num?)?.toInt() ?? 0,
      isFeatured: json['isFeatured'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRegistered: json['isRegistered'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.parse(json['registeredAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      finishTimeSeconds: (json['finishTimeSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RaceEventImplToJson(_$RaceEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'sportType': _$WorkoutSportTypeEnumMap[instance.sportType]!,
      'distanceMeters': instance.distanceMeters,
      'location': instance.location,
      'city': instance.city,
      'country': instance.country,
      'eventDate': instance.eventDate.toIso8601String(),
      'registrationUrl': instance.registrationUrl,
      'imageUrl': instance.imageUrl,
      'xpReward': instance.xpReward,
      'bonusXpReward': instance.bonusXpReward,
      'isFeatured': instance.isFeatured,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRegistered': instance.isRegistered,
      'isCompleted': instance.isCompleted,
      'registeredAt': instance.registeredAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'finishTimeSeconds': instance.finishTimeSeconds,
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
