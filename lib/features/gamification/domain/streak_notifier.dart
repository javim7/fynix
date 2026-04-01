import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/models/xp_event.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/gamification/data/gamification_repository.dart';

part 'streak_notifier.g.dart';

@riverpod
Future<List<XpEvent>> xpHistory(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(gamificationRepositoryProvider).fetchXpHistory(user.id);
}
