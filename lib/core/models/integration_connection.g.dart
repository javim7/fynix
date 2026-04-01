// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integration_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntegrationConnectionImpl _$$IntegrationConnectionImplFromJson(
        Map<String, dynamic> json) =>
    _$IntegrationConnectionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      provider: $enumDecode(_$IntegrationProviderEnumMap, json['provider']),
      isConnected: json['isConnected'] as bool? ?? false,
      tokenExpiresAt: json['tokenExpiresAt'] == null
          ? null
          : DateTime.parse(json['tokenExpiresAt'] as String),
      providerUserId: json['providerUserId'] as String?,
      providerUsername: json['providerUsername'] as String?,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
      lastSyncCursor: json['lastSyncCursor'] as String?,
      syncError: json['syncError'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$IntegrationConnectionImplToJson(
        _$IntegrationConnectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'provider': _$IntegrationProviderEnumMap[instance.provider]!,
      'isConnected': instance.isConnected,
      'tokenExpiresAt': instance.tokenExpiresAt?.toIso8601String(),
      'providerUserId': instance.providerUserId,
      'providerUsername': instance.providerUsername,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
      'lastSyncCursor': instance.lastSyncCursor,
      'syncError': instance.syncError,
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
