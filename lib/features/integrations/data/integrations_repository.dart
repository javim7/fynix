import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/integration_connection.dart';
import 'package:fynix/core/models/workout.dart';

part 'integrations_repository.g.dart';

@riverpod
IntegrationsRepository integrationsRepository(Ref ref) =>
    IntegrationsRepository();

class IntegrationsRepository {
  final _client = Supabase.instance.client;

  Future<List<IntegrationConnection>> fetchUserIntegrations(
      String userId) async {
    final data = await _client
        .from('integrations')
        .select()
        .eq('user_id', userId);

    return (data as List)
        .map((e) =>
            IntegrationConnection.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<IntegrationConnection?> fetchIntegration(
      String userId, IntegrationProvider provider) async {
    final data = await _client
        .from('integrations')
        .select()
        .eq('user_id', userId)
        .eq('provider', provider.name)
        .maybeSingle();

    if (data == null) return null;
    return IntegrationConnection.fromJson(data as Map<String, dynamic>);
  }

  Future<void> upsertIntegration({
    required String userId,
    required IntegrationProvider provider,
    required bool isConnected,
    String? providerUserId,
    String? providerUsername,
  }) async {
    await _client.from('integrations').upsert(
      {
        'user_id': userId,
        'provider': provider.name,
        'is_connected': isConnected,
        if (providerUserId != null) 'provider_user_id': providerUserId,
        if (providerUsername != null) 'provider_username': providerUsername,
      },
      onConflict: 'user_id,provider',
    );
  }

  Future<void> disconnect({
    required String userId,
    required IntegrationProvider provider,
  }) async {
    await _client
        .from('integrations')
        .update({
          'is_connected': false,
          'access_token': null,
          'refresh_token': null,
          'sync_error': null,
        })
        .eq('user_id', userId)
        .eq('provider', provider.name);
  }
}
