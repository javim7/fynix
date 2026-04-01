import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/user_profile.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepository();

/// Handles all Supabase Auth operations: sign in, sign up, sign out.
class AuthRepository {
  final _client = Supabase.instance.client;

  /// Sign in with email and password.
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) =>
      _client.auth.signInWithPassword(email: email, password: password);

  /// Register with email and password, then create user profile row.
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String displayName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username, 'display_name': displayName},
    );

    if (response.user != null) {
      await _createUserProfile(
        id: response.user!.id,
        email: email,
        username: username,
        displayName: displayName,
      );
    }

    return response;
  }

  /// Sign in with Google OAuth.
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(OAuthProvider.google);
  }

  /// Sign in with Apple OAuth (iOS only).
  Future<void> signInWithApple() async {
    await _client.auth.signInWithOAuth(OAuthProvider.apple);
  }

  /// Sign out the current user.
  Future<void> signOut() => _client.auth.signOut();

  /// Fetch the current user's profile from `users` table.
  Future<UserProfile?> fetchCurrentProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final data = await _client
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return UserProfile.fromJson(data);
  }

  /// Stream of auth state changes.
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Current auth session (null if not logged in).
  Session? get currentSession => _client.auth.currentSession;

  Future<void> _createUserProfile({
    required String id,
    required String email,
    required String username,
    required String displayName,
  }) async {
    await _client.from('users').insert({
      'id': id,
      'email': email,
      'username': username,
      'display_name': displayName,
    });
  }
}
