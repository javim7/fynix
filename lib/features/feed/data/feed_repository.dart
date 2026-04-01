import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/feed_post.dart';

part 'feed_repository.g.dart';

@riverpod
FeedRepository feedRepository(Ref ref) => FeedRepository();

class FeedRepository {
  final _client = Supabase.instance.client;

  /// Fetches the social feed for [userId]: posts from followed users.
  Future<List<FeedPost>> fetchFeed({
    required String userId,
    int limit = 20,
    DateTime? before,
  }) async {
    var baseQuery = _client
        .from('feed_posts')
        .select('*, author:users(*), workout:workouts(*)')
        .eq('is_public', true);

    if (before != null) {
      baseQuery = baseQuery.lt('created_at', before.toIso8601String());
    }

    final data = await baseQuery
        .order('created_at', ascending: false)
        .limit(limit);
    return (data as List)
        .map((e) => FeedPost.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<FeedPost?> fetchPost(String postId) async {
    final data = await _client
        .from('feed_posts')
        .select('*, author:users(*), workout:workouts(*)')
        .eq('id', postId)
        .single();
    return FeedPost.fromJson(data as Map<String, dynamic>);
  }

  Future<FeedPost> createPost({
    required String authorId,
    String? workoutId,
    PostType postType = PostType.workout,
    String? caption,
    String? imageUrl,
  }) async {
    final data = await _client
        .from('feed_posts')
        .insert({
          'author_id': authorId,
          if (workoutId != null) 'workout_id': workoutId,
          'post_type': postType.name,
          if (caption != null) 'caption': caption,
          if (imageUrl != null) 'image_url': imageUrl,
        })
        .select('*, author:users(*)')
        .single();
    return FeedPost.fromJson(data as Map<String, dynamic>);
  }

  Future<void> likePost(String postId, String userId) async {
    await _client.from('post_likes').insert({'post_id': postId, 'user_id': userId});
  }

  Future<void> unlikePost(String postId, String userId) async {
    await _client
        .from('post_likes')
        .delete()
        .eq('post_id', postId)
        .eq('user_id', userId);
  }

  Future<List<PostComment>> fetchComments(String postId) async {
    final data = await _client
        .from('post_comments')
        .select('*, author:users(*)')
        .eq('post_id', postId)
        .order('created_at');
    return (data as List)
        .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PostComment> addComment({
    required String postId,
    required String authorId,
    required String content,
  }) async {
    final data = await _client
        .from('post_comments')
        .insert({'post_id': postId, 'author_id': authorId, 'content': content})
        .select('*, author:users(*)')
        .single();
    return PostComment.fromJson(data as Map<String, dynamic>);
  }
}
