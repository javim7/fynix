import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/user_profile.dart';

part 'social_repository.g.dart';

@riverpod
SocialRepository socialRepository(Ref ref) => SocialRepository();

class SocialRepository {
  final _client = Supabase.instance.client;

  Future<List<UserProfile>> fetchFollowers(String userId) async {
    final data = await _client
        .from('follows')
        .select('follower:users!follower_id(*)')
        .eq('following_id', userId);
    return (data as List)
        .map((e) => UserProfile.fromJson(
            (e as Map<String, dynamic>)['follower'] as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserProfile>> fetchFollowing(String userId) async {
    final data = await _client
        .from('follows')
        .select('following:users!following_id(*)')
        .eq('follower_id', userId);
    return (data as List)
        .map((e) => UserProfile.fromJson(
            (e as Map<String, dynamic>)['following'] as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserProfile>> searchUsers(String query) async {
    final data = await _client
        .from('users')
        .select()
        .or('username.ilike.%$query%,display_name.ilike.%$query%')
        .limit(20);
    return (data as List)
        .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> follow(String followerId, String followingId) async {
    await _client.from('follows').insert({
      'follower_id': followerId,
      'following_id': followingId,
    });
  }

  Future<void> unfollow(String followerId, String followingId) async {
    await _client
        .from('follows')
        .delete()
        .eq('follower_id', followerId)
        .eq('following_id', followingId);
  }

  Future<bool> isFollowing(String followerId, String followingId) async {
    final data = await _client
        .from('follows')
        .select('follower_id')
        .eq('follower_id', followerId)
        .eq('following_id', followingId)
        .maybeSingle();
    return data != null;
  }

  Future<UserProfile?> fetchUserByUsername(String username) async {
    final data = await _client
        .from('users')
        .select()
        .eq('username', username)
        .maybeSingle();
    if (data == null) return null;
    return UserProfile.fromJson(data as Map<String, dynamic>);
  }
}
