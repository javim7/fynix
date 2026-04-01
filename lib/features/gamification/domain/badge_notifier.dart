import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/models/badge_model.dart';
import 'package:fynix/core/models/challenge.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/gamification/data/gamification_repository.dart';

part 'badge_notifier.g.dart';

@riverpod
Future<List<BadgeModel>> userBadges(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(gamificationRepositoryProvider).fetchUserBadges(user.id);
}

@riverpod
Future<List<Challenge>> dailyChallenges(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref
      .read(gamificationRepositoryProvider)
      .fetchDailyChallenges(user.id);
}

@riverpod
Future<List<Map<String, dynamic>>> weeklyLeaderboard(Ref ref) async {
  return ref.read(gamificationRepositoryProvider).fetchWeeklyLeaderboard();
}
