import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/user_profile.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) => ProfileRepository();

class ProfileRepository {
  final _client = Supabase.instance.client;

  Future<UserProfile?> fetchProfile(String userId) async {
    final data = await _client
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    return UserProfile.fromJson(data as Map<String, dynamic>);
  }

  Future<void> updateProfile({
    required String userId,
    String? displayName,
    String? bio,
    String? city,
    String? avatarId,
  }) async {
    await _client.from('users').update({
      if (displayName != null) 'display_name': displayName,
      if (bio != null) 'bio': bio,
      if (city != null) 'city': city,
      if (avatarId != null) 'avatar_id': avatarId,
    }).eq('id', userId);
  }
}
