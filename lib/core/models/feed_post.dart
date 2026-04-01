import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/models/workout.dart';

part 'feed_post.freezed.dart';
part 'feed_post.g.dart';

/// Post type matching the database enum.
enum PostType {
  workout,
  photo,
  milestone,
  challengeComplete,
  eventComplete,
}

/// A feed post — mirrors the `feed_posts` table with joined data.
@freezed
abstract class FeedPost with _$FeedPost {
  const factory FeedPost({
    required String id,
    required String authorId,
    String? workoutId,
    @Default(PostType.workout) PostType postType,
    String? caption,
    String? imageUrl,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(true) bool isPublic,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Joined fields
    UserProfile? author,
    Workout? workout,
    @Default(false) bool isLikedByMe,
  }) = _FeedPost;

  factory FeedPost.fromJson(Map<String, dynamic> json) =>
      _$FeedPostFromJson(json);
}

/// A single comment on a feed post — mirrors `post_comments`.
@freezed
abstract class PostComment with _$PostComment {
  const factory PostComment({
    required String id,
    required String postId,
    required String authorId,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Joined
    UserProfile? author,
  }) = _PostComment;

  factory PostComment.fromJson(Map<String, dynamic> json) =>
      _$PostCommentFromJson(json);
}
