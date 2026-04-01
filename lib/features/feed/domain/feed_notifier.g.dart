// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedPostsHash() => r'16323e623eef70d43cf45468934589f4b2c53997';

/// See also [feedPosts].
@ProviderFor(feedPosts)
final feedPostsProvider = AutoDisposeFutureProvider<List<FeedPost>>.internal(
  feedPosts,
  name: r'feedPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$feedPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedPostsRef = AutoDisposeFutureProviderRef<List<FeedPost>>;
String _$feedPostDetailHash() => r'4c7d466d7bc4f9938a60365d2c4bcf3754bb89cc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [feedPostDetail].
@ProviderFor(feedPostDetail)
const feedPostDetailProvider = FeedPostDetailFamily();

/// See also [feedPostDetail].
class FeedPostDetailFamily extends Family<AsyncValue<FeedPost?>> {
  /// See also [feedPostDetail].
  const FeedPostDetailFamily();

  /// See also [feedPostDetail].
  FeedPostDetailProvider call(
    String postId,
  ) {
    return FeedPostDetailProvider(
      postId,
    );
  }

  @override
  FeedPostDetailProvider getProviderOverride(
    covariant FeedPostDetailProvider provider,
  ) {
    return call(
      provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedPostDetailProvider';
}

/// See also [feedPostDetail].
class FeedPostDetailProvider extends AutoDisposeFutureProvider<FeedPost?> {
  /// See also [feedPostDetail].
  FeedPostDetailProvider(
    String postId,
  ) : this._internal(
          (ref) => feedPostDetail(
            ref as FeedPostDetailRef,
            postId,
          ),
          from: feedPostDetailProvider,
          name: r'feedPostDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$feedPostDetailHash,
          dependencies: FeedPostDetailFamily._dependencies,
          allTransitiveDependencies:
              FeedPostDetailFamily._allTransitiveDependencies,
          postId: postId,
        );

  FeedPostDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  Override overrideWith(
    FutureOr<FeedPost?> Function(FeedPostDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedPostDetailProvider._internal(
        (ref) => create(ref as FeedPostDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FeedPost?> createElement() {
    return _FeedPostDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedPostDetailProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedPostDetailRef on AutoDisposeFutureProviderRef<FeedPost?> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _FeedPostDetailProviderElement
    extends AutoDisposeFutureProviderElement<FeedPost?> with FeedPostDetailRef {
  _FeedPostDetailProviderElement(super.provider);

  @override
  String get postId => (origin as FeedPostDetailProvider).postId;
}

String _$postCommentsHash() => r'239bbdf27237ce0adbcfa397ce76e9fccb522c03';

/// See also [postComments].
@ProviderFor(postComments)
const postCommentsProvider = PostCommentsFamily();

/// See also [postComments].
class PostCommentsFamily extends Family<AsyncValue<List<PostComment>>> {
  /// See also [postComments].
  const PostCommentsFamily();

  /// See also [postComments].
  PostCommentsProvider call(
    String postId,
  ) {
    return PostCommentsProvider(
      postId,
    );
  }

  @override
  PostCommentsProvider getProviderOverride(
    covariant PostCommentsProvider provider,
  ) {
    return call(
      provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postCommentsProvider';
}

/// See also [postComments].
class PostCommentsProvider
    extends AutoDisposeFutureProvider<List<PostComment>> {
  /// See also [postComments].
  PostCommentsProvider(
    String postId,
  ) : this._internal(
          (ref) => postComments(
            ref as PostCommentsRef,
            postId,
          ),
          from: postCommentsProvider,
          name: r'postCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postCommentsHash,
          dependencies: PostCommentsFamily._dependencies,
          allTransitiveDependencies:
              PostCommentsFamily._allTransitiveDependencies,
          postId: postId,
        );

  PostCommentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  Override overrideWith(
    FutureOr<List<PostComment>> Function(PostCommentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostCommentsProvider._internal(
        (ref) => create(ref as PostCommentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PostComment>> createElement() {
    return _PostCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentsProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostCommentsRef on AutoDisposeFutureProviderRef<List<PostComment>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _PostCommentsProviderElement
    extends AutoDisposeFutureProviderElement<List<PostComment>>
    with PostCommentsRef {
  _PostCommentsProviderElement(super.provider);

  @override
  String get postId => (origin as PostCommentsProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
