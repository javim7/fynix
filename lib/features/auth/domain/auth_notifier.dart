import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/features/auth/data/auth_repository.dart';

part 'auth_notifier.g.dart';

/// Exposes the current [UserProfile] as async state.
/// Null means the user is not authenticated.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UserProfile?> build() async {
    // Listen to auth state changes and rebuild provider
    ref.listen(
      authRepositoryProvider.select((r) => r.authStateChanges),
      (_, __) => ref.invalidateSelf(),
    );

    final repo = ref.read(authRepositoryProvider);
    if (repo.currentSession == null) return null;
    return repo.fetchCurrentProfile();
  }

  /// Sign in with email + password.
  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final repo = ref.read(authRepositoryProvider);
        await repo.signInWithEmail(email: email, password: password);
        return repo.fetchCurrentProfile();
      },
    );
  }

  /// Register a new account.
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String displayName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final repo = ref.read(authRepositoryProvider);
        await repo.signUpWithEmail(
          email: email,
          password: password,
          username: username,
          displayName: displayName,
        );
        return repo.fetchCurrentProfile();
      },
    );
  }

  /// Sign out.
  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }
}

/// Whether any user is currently signed in.
@riverpod
bool isAuthenticated(Ref ref) {
  return Supabase.instance.client.auth.currentSession != null;
}
