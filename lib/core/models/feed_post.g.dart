// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedPostImpl _$$FeedPostImplFromJson(Map<String, dynamic> json) =>
    _$FeedPostImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      workoutId: json['workoutId'] as String?,
      postType: $enumDecodeNullable(_$PostTypeEnumMap, json['postType']) ??
          PostType.workout,
      caption: json['caption'] as String?,
      imageUrl: json['imageUrl'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isPublic: json['isPublic'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      author: json['author'] == null
          ? null
          : UserProfile.fromJson(json['author'] as Map<String, dynamic>),
      workout: json['workout'] == null
          ? null
          : Workout.fromJson(json['workout'] as Map<String, dynamic>),
      isLikedByMe: json['isLikedByMe'] as bool? ?? false,
    );

Map<String, dynamic> _$$FeedPostImplToJson(_$FeedPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'workoutId': instance.workoutId,
      'postType': _$PostTypeEnumMap[instance.postType]!,
      'caption': instance.caption,
      'imageUrl': instance.imageUrl,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'isPublic': instance.isPublic,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'author': instance.author,
      'workout': instance.workout,
      'isLikedByMe': instance.isLikedByMe,
    };

const _$PostTypeEnumMap = {
  PostType.workout: 'workout',
  PostType.photo: 'photo',
  PostType.milestone: 'milestone',
  PostType.challengeComplete: 'challengeComplete',
  PostType.eventComplete: 'eventComplete',
};

_$PostCommentImpl _$$PostCommentImplFromJson(Map<String, dynamic> json) =>
    _$PostCommentImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      author: json['author'] == null
          ? null
          : UserProfile.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostCommentImplToJson(_$PostCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'author': instance.author,
    };
