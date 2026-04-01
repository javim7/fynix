import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/social/data/social_repository.dart';

part 'social_notifier.g.dart';

@riverpod
Future<List<UserProfile>> followers(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(socialRepositoryProvider).fetchFollowers(user.id);
}

@riverpod
Future<List<UserProfile>> following(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(socialRepositoryProvider).fetchFollowing(user.id);
}

@riverpod
Future<UserProfile?> userByUsername(Ref ref, String username) async {
  return ref.read(socialRepositoryProvider).fetchUserByUsername(username);
}
