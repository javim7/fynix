import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/models/integration_connection.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/integrations/data/integrations_repository.dart';

part 'integrations_notifier.g.dart';

@riverpod
Future<List<IntegrationConnection>> integrationsList(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref
      .read(integrationsRepositoryProvider)
      .fetchUserIntegrations(user.id);
}
