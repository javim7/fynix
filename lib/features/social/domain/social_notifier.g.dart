// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$followersHash() => r'c4875e897053013752cb0fda6e63e95c2d0c907e';

/// See also [followers].
@ProviderFor(followers)
final followersProvider = AutoDisposeFutureProvider<List<UserProfile>>.internal(
  followers,
  name: r'followersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$followersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FollowersRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
String _$followingHash() => r'32ef7bbe86d10afa95a46fadb359774070a5a591';

/// See also [following].
@ProviderFor(following)
final followingProvider = AutoDisposeFutureProvider<List<UserProfile>>.internal(
  following,
  name: r'followingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$followingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FollowingRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
String _$userByUsernameHash() => r'623a744f9ed013c0db6a494257484ad43cf7440c';

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

/// See also [userByUsername].
@ProviderFor(userByUsername)
const userByUsernameProvider = UserByUsernameFamily();

/// See also [userByUsername].
class UserByUsernameFamily extends Family<AsyncValue<UserProfile?>> {
  /// See also [userByUsername].
  const UserByUsernameFamily();

  /// See also [userByUsername].
  UserByUsernameProvider call(
    String username,
  ) {
    return UserByUsernameProvider(
      username,
    );
  }

  @override
  UserByUsernameProvider getProviderOverride(
    covariant UserByUsernameProvider provider,
  ) {
    return call(
      provider.username,
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
  String? get name => r'userByUsernameProvider';
}

/// See also [userByUsername].
class UserByUsernameProvider extends AutoDisposeFutureProvider<UserProfile?> {
  /// See also [userByUsername].
  UserByUsernameProvider(
    String username,
  ) : this._internal(
          (ref) => userByUsername(
            ref as UserByUsernameRef,
            username,
          ),
          from: userByUsernameProvider,
          name: r'userByUsernameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userByUsernameHash,
          dependencies: UserByUsernameFamily._dependencies,
          allTransitiveDependencies:
              UserByUsernameFamily._allTransitiveDependencies,
          username: username,
        );

  UserByUsernameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
  }) : super.internal();

  final String username;

  @override
  Override overrideWith(
    FutureOr<UserProfile?> Function(UserByUsernameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserByUsernameProvider._internal(
        (ref) => create(ref as UserByUsernameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserProfile?> createElement() {
    return _UserByUsernameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserByUsernameProvider && other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserByUsernameRef on AutoDisposeFutureProviderRef<UserProfile?> {
  /// The parameter `username` of this provider.
  String get username;
}

class _UserByUsernameProviderElement
    extends AutoDisposeFutureProviderElement<UserProfile?>
    with UserByUsernameRef {
  _UserByUsernameProviderElement(super.provider);

  @override
  String get username => (origin as UserByUsernameProvider).username;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
