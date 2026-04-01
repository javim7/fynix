// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutSplitImpl _$$WorkoutSplitImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSplitImpl(
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      paceSecondsPerKm: (json['paceSecondsPerKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WorkoutSplitImplToJson(_$WorkoutSplitImpl instance) =>
    <String, dynamic>{
      'distanceMeters': instance.distanceMeters,
      'durationSeconds': instance.durationSeconds,
      'paceSecondsPerKm': instance.paceSecondsPerKm,
    };

_$XpBreakdownDataImpl _$$XpBreakdownDataImplFromJson(
        Map<String, dynamic> json) =>
    _$XpBreakdownDataImpl(
      baseXp: (json['baseXp'] as num).toInt(),
      streakBonus: (json['streakBonus'] as num?)?.toInt() ?? 0,
      prBonus: (json['prBonus'] as num?)?.toInt() ?? 0,
      morningBonus: (json['morningBonus'] as num?)?.toInt() ?? 0,
      challengeBonus: (json['challengeBonus'] as num?)?.toInt() ?? 0,
      eventBonus: (json['eventBonus'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num).toInt(),
      ratePerKm: (json['ratePerKm'] as num?)?.toDouble(),
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      sport: json['sport'] as String?,
    );

Map<String, dynamic> _$$XpBreakdownDataImplToJson(
        _$XpBreakdownDataImpl instance) =>
    <String, dynamic>{
      'baseXp': instance.baseXp,
      'streakBonus': instance.streakBonus,
      'prBonus': instance.prBonus,
      'morningBonus': instance.morningBonus,
      'challengeBonus': instance.challengeBonus,
      'eventBonus': instance.eventBonus,
      'total': instance.total,
      'ratePerKm': instance.ratePerKm,
      'distanceKm': instance.distanceKm,
      'sport': instance.sport,
    };

_$WorkoutImpl _$$WorkoutImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      integrationId: json['integrationId'] as String?,
      provider:
          $enumDecodeNullable(_$IntegrationProviderEnumMap, json['provider']),
      providerActivityId: json['providerActivityId'] as String?,
      sportType: $enumDecode(_$WorkoutSportTypeEnumMap, json['sportType']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      distanceMeters: (json['distanceMeters'] as num?)?.toDouble() ?? 0,
      avgPaceSecondsPerKm: (json['avgPaceSecondsPerKm'] as num?)?.toDouble(),
      avgSpeedKmh: (json['avgSpeedKmh'] as num?)?.toDouble(),
      maxSpeedKmh: (json['maxSpeedKmh'] as num?)?.toDouble(),
      elevationGainMeters:
          (json['elevationGainMeters'] as num?)?.toDouble() ?? 0,
      elevationLossMeters:
          (json['elevationLossMeters'] as num?)?.toDouble() ?? 0,
      avgHeartRate: (json['avgHeartRate'] as num?)?.toInt(),
      maxHeartRate: (json['maxHeartRate'] as num?)?.toInt(),
      calories: (json['calories'] as num?)?.toInt(),
      polyline: json['polyline'] as String?,
      mapSnapshotUrl: json['mapSnapshotUrl'] as String?,
      splits: (json['splits'] as List<dynamic>?)
              ?.map((e) => WorkoutSplit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
      xpBreakdown: json['xpBreakdown'] == null
          ? null
          : XpBreakdownData.fromJson(
              json['xpBreakdown'] as Map<String, dynamic>),
      isDuplicate: json['isDuplicate'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$WorkoutImplToJson(_$WorkoutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'integrationId': instance.integrationId,
      'provider': _$IntegrationProviderEnumMap[instance.provider],
      'providerActivityId': instance.providerActivityId,
      'sportType': _$WorkoutSportTypeEnumMap[instance.sportType]!,
      'name': instance.name,
      'description': instance.description,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'distanceMeters': instance.distanceMeters,
      'avgPaceSecondsPerKm': instance.avgPaceSecondsPerKm,
      'avgSpeedKmh': instance.avgSpeedKmh,
      'maxSpeedKmh': instance.maxSpeedKmh,
      'elevationGainMeters': instance.elevationGainMeters,
      'elevationLossMeters': instance.elevationLossMeters,
      'avgHeartRate': instance.avgHeartRate,
      'maxHeartRate': instance.maxHeartRate,
      'calories': instance.calories,
      'polyline': instance.polyline,
      'mapSnapshotUrl': instance.mapSnapshotUrl,
      'splits': instance.splits,
      'xpEarned': instance.xpEarned,
      'xpBreakdown': instance.xpBreakdown,
      'isDuplicate': instance.isDuplicate,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$IntegrationProviderEnumMap = {
  IntegrationProvider.appleHealth: 'appleHealth',
  IntegrationProvider.googleFit: 'googleFit',
  IntegrationProvider.strava: 'strava',
  IntegrationProvider.garmin: 'garmin',
  IntegrationProvider.coros: 'coros',
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
