import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fynix/core/models/workout.dart';

part 'integration_connection.freezed.dart';
part 'integration_connection.g.dart';

/// A connected fitness service — mirrors the `integrations` table.
@freezed
abstract class IntegrationConnection with _$IntegrationConnection {
  const factory IntegrationConnection({
    required String id,
    required String userId,
    required IntegrationProvider provider,
    @Default(false) bool isConnected,
    // Note: tokens are NOT returned to client — only metadata
    DateTime? tokenExpiresAt,
    String? providerUserId,
    String? providerUsername,
    DateTime? lastSyncedAt,
    String? lastSyncCursor,
    String? syncError,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IntegrationConnection;

  factory IntegrationConnection.fromJson(Map<String, dynamic> json) =>
      _$IntegrationConnectionFromJson(json);
}
