import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/models/feed_post.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/feed/data/feed_repository.dart';

part 'feed_notifier.g.dart';

@riverpod
Future<List<FeedPost>> feedPosts(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(feedRepositoryProvider).fetchFeed(userId: user.id);
}

@riverpod
Future<FeedPost?> feedPostDetail(Ref ref, String postId) async {
  return ref.read(feedRepositoryProvider).fetchPost(postId);
}

@riverpod
Future<List<PostComment>> postComments(Ref ref, String postId) async {
  return ref.read(feedRepositoryProvider).fetchComments(postId);
}
