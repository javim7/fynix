// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String get avatarId => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError; // Gamification
  int get level => throw _privateConstructorUsedError;
  int get totalXp => throw _privateConstructorUsedError;
  int get xpToNextLevel => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  DateTime? get lastActivityDate => throw _privateConstructorUsedError;
  int get streakFreezesRemaining =>
      throw _privateConstructorUsedError; // Social
  int get followingCount => throw _privateConstructorUsedError;
  int get followerCount => throw _privateConstructorUsedError; // Totals
  int get totalWorkouts => throw _privateConstructorUsedError;
  int get totalDistanceMeters => throw _privateConstructorUsedError;
  int get totalDurationSeconds =>
      throw _privateConstructorUsedError; // Subscription
  SubscriptionStatus get subscriptionStatus =>
      throw _privateConstructorUsedError;
  SubscriptionTier get subscriptionTier => throw _privateConstructorUsedError;
  DateTime? get subscriptionExpiresAt => throw _privateConstructorUsedError;
  String? get revenuecatCustomerId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String id,
      String username,
      String displayName,
      String email,
      String? bio,
      String avatarId,
      String? city,
      String country,
      int level,
      int totalXp,
      int xpToNextLevel,
      int currentStreak,
      int longestStreak,
      DateTime? lastActivityDate,
      int streakFreezesRemaining,
      int followingCount,
      int followerCount,
      int totalWorkouts,
      int totalDistanceMeters,
      int totalDurationSeconds,
      SubscriptionStatus subscriptionStatus,
      SubscriptionTier subscriptionTier,
      DateTime? subscriptionExpiresAt,
      String? revenuecatCustomerId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = null,
    Object? email = null,
    Object? bio = freezed,
    Object? avatarId = null,
    Object? city = freezed,
    Object? country = null,
    Object? level = null,
    Object? totalXp = null,
    Object? xpToNextLevel = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastActivityDate = freezed,
    Object? streakFreezesRemaining = null,
    Object? followingCount = null,
    Object? followerCount = null,
    Object? totalWorkouts = null,
    Object? totalDistanceMeters = null,
    Object? totalDurationSeconds = null,
    Object? subscriptionStatus = null,
    Object? subscriptionTier = null,
    Object? subscriptionExpiresAt = freezed,
    Object? revenuecatCustomerId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarId: null == avatarId
          ? _value.avatarId
          : avatarId // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      totalXp: null == totalXp
          ? _value.totalXp
          : totalXp // ignore: cast_nullable_to_non_nullable
              as int,
      xpToNextLevel: null == xpToNextLevel
          ? _value.xpToNextLevel
          : xpToNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityDate: freezed == lastActivityDate
          ? _value.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      streakFreezesRemaining: null == streakFreezesRemaining
          ? _value.streakFreezesRemaining
          : streakFreezesRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalWorkouts: null == totalWorkouts
          ? _value.totalWorkouts
          : totalWorkouts // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistanceMeters: null == totalDistanceMeters
          ? _value.totalDistanceMeters
          : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
              as int,
      totalDurationSeconds: null == totalDurationSeconds
          ? _value.totalDurationSeconds
          : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
      subscriptionTier: null == subscriptionTier
          ? _value.subscriptionTier
          : subscriptionTier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      subscriptionExpiresAt: freezed == subscriptionExpiresAt
          ? _value.subscriptionExpiresAt
          : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revenuecatCustomerId: freezed == revenuecatCustomerId
          ? _value.revenuecatCustomerId
          : revenuecatCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String displayName,
      String email,
      String? bio,
      String avatarId,
      String? city,
      String country,
      int level,
      int totalXp,
      int xpToNextLevel,
      int currentStreak,
      int longestStreak,
      DateTime? lastActivityDate,
      int streakFreezesRemaining,
      int followingCount,
      int followerCount,
      int totalWorkouts,
      int totalDistanceMeters,
      int totalDurationSeconds,
      SubscriptionStatus subscriptionStatus,
      SubscriptionTier subscriptionTier,
      DateTime? subscriptionExpiresAt,
      String? revenuecatCustomerId,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = null,
    Object? email = null,
    Object? bio = freezed,
    Object? avatarId = null,
    Object? city = freezed,
    Object? country = null,
    Object? level = null,
    Object? totalXp = null,
    Object? xpToNextLevel = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastActivityDate = freezed,
    Object? streakFreezesRemaining = null,
    Object? followingCount = null,
    Object? followerCount = null,
    Object? totalWorkouts = null,
    Object? totalDistanceMeters = null,
    Object? totalDurationSeconds = null,
    Object? subscriptionStatus = null,
    Object? subscriptionTier = null,
    Object? subscriptionExpiresAt = freezed,
    Object? revenuecatCustomerId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarId: null == avatarId
          ? _value.avatarId
          : avatarId // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      totalXp: null == totalXp
          ? _value.totalXp
          : totalXp // ignore: cast_nullable_to_non_nullable
              as int,
      xpToNextLevel: null == xpToNextLevel
          ? _value.xpToNextLevel
          : xpToNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityDate: freezed == lastActivityDate
          ? _value.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      streakFreezesRemaining: null == streakFreezesRemaining
          ? _value.streakFreezesRemaining
          : streakFreezesRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalWorkouts: null == totalWorkouts
          ? _value.totalWorkouts
          : totalWorkouts // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistanceMeters: null == totalDistanceMeters
          ? _value.totalDistanceMeters
          : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
              as int,
      totalDurationSeconds: null == totalDurationSeconds
          ? _value.totalDurationSeconds
          : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
      subscriptionTier: null == subscriptionTier
          ? _value.subscriptionTier
          : subscriptionTier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      subscriptionExpiresAt: freezed == subscriptionExpiresAt
          ? _value.subscriptionExpiresAt
          : subscriptionExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revenuecatCustomerId: freezed == revenuecatCustomerId
          ? _value.revenuecatCustomerId
          : revenuecatCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.id,
      required this.username,
      required this.displayName,
      required this.email,
      this.bio,
      this.avatarId = 'default',
      this.city,
      this.country = 'GT',
      this.level = 1,
      this.totalXp = 0,
      this.xpToNextLevel = 500,
      this.currentStreak = 0,
      this.longestStreak = 0,
      this.lastActivityDate,
      this.streakFreezesRemaining = 0,
      this.followingCount = 0,
      this.followerCount = 0,
      this.totalWorkouts = 0,
      this.totalDistanceMeters = 0,
      this.totalDurationSeconds = 0,
      this.subscriptionStatus = SubscriptionStatus.free,
      this.subscriptionTier = SubscriptionTier.free,
      this.subscriptionExpiresAt,
      this.revenuecatCustomerId,
      required this.createdAt,
      required this.updatedAt});

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String? bio;
  @override
  @JsonKey()
  final String avatarId;
  @override
  final String? city;
  @override
  @JsonKey()
  final String country;
// Gamification
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int totalXp;
  @override
  @JsonKey()
  final int xpToNextLevel;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  final DateTime? lastActivityDate;
  @override
  @JsonKey()
  final int streakFreezesRemaining;
// Social
  @override
  @JsonKey()
  final int followingCount;
  @override
  @JsonKey()
  final int followerCount;
// Totals
  @override
  @JsonKey()
  final int totalWorkouts;
  @override
  @JsonKey()
  final int totalDistanceMeters;
  @override
  @JsonKey()
  final int totalDurationSeconds;
// Subscription
  @override
  @JsonKey()
  final SubscriptionStatus subscriptionStatus;
  @override
  @JsonKey()
  final SubscriptionTier subscriptionTier;
  @override
  final DateTime? subscriptionExpiresAt;
  @override
  final String? revenuecatCustomerId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, username: $username, displayName: $displayName, email: $email, bio: $bio, avatarId: $avatarId, city: $city, country: $country, level: $level, totalXp: $totalXp, xpToNextLevel: $xpToNextLevel, currentStreak: $currentStreak, longestStreak: $longestStreak, lastActivityDate: $lastActivityDate, streakFreezesRemaining: $streakFreezesRemaining, followingCount: $followingCount, followerCount: $followerCount, totalWorkouts: $totalWorkouts, totalDistanceMeters: $totalDistanceMeters, totalDurationSeconds: $totalDurationSeconds, subscriptionStatus: $subscriptionStatus, subscriptionTier: $subscriptionTier, subscriptionExpiresAt: $subscriptionExpiresAt, revenuecatCustomerId: $revenuecatCustomerId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarId, avatarId) ||
                other.avatarId == avatarId) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.totalXp, totalXp) || other.totalXp == totalXp) &&
            (identical(other.xpToNextLevel, xpToNextLevel) ||
                other.xpToNextLevel == xpToNextLevel) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastActivityDate, lastActivityDate) ||
                other.lastActivityDate == lastActivityDate) &&
            (identical(other.streakFreezesRemaining, streakFreezesRemaining) ||
                other.streakFreezesRemaining == streakFreezesRemaining) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.totalWorkouts, totalWorkouts) ||
                other.totalWorkouts == totalWorkouts) &&
            (identical(other.totalDistanceMeters, totalDistanceMeters) ||
                other.totalDistanceMeters == totalDistanceMeters) &&
            (identical(other.totalDurationSeconds, totalDurationSeconds) ||
                other.totalDurationSeconds == totalDurationSeconds) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus) &&
            (identical(other.subscriptionTier, subscriptionTier) ||
                other.subscriptionTier == subscriptionTier) &&
            (identical(other.subscriptionExpiresAt, subscriptionExpiresAt) ||
                other.subscriptionExpiresAt == subscriptionExpiresAt) &&
            (identical(other.revenuecatCustomerId, revenuecatCustomerId) ||
                other.revenuecatCustomerId == revenuecatCustomerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        username,
        displayName,
        email,
        bio,
        avatarId,
        city,
        country,
        level,
        totalXp,
        xpToNextLevel,
        currentStreak,
        longestStreak,
        lastActivityDate,
        streakFreezesRemaining,
        followingCount,
        followerCount,
        totalWorkouts,
        totalDistanceMeters,
        totalDurationSeconds,
        subscriptionStatus,
        subscriptionTier,
        subscriptionExpiresAt,
        revenuecatCustomerId,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final String id,
      required final String username,
      required final String displayName,
      required final String email,
      final String? bio,
      final String avatarId,
      final String? city,
      final String country,
      final int level,
      final int totalXp,
      final int xpToNextLevel,
      final int currentStreak,
      final int longestStreak,
      final DateTime? lastActivityDate,
      final int streakFreezesRemaining,
      final int followingCount,
      final int followerCount,
      final int totalWorkouts,
      final int totalDistanceMeters,
      final int totalDurationSeconds,
      final SubscriptionStatus subscriptionStatus,
      final SubscriptionTier subscriptionTier,
      final DateTime? subscriptionExpiresAt,
      final String? revenuecatCustomerId,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get displayName;
  @override
  String get email;
  @override
  String? get bio;
  @override
  String get avatarId;
  @override
  String? get city;
  @override
  String get country; // Gamification
  @override
  int get level;
  @override
  int get totalXp;
  @override
  int get xpToNextLevel;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  DateTime? get lastActivityDate;
  @override
  int get streakFreezesRemaining; // Social
  @override
  int get followingCount;
  @override
  int get followerCount; // Totals
  @override
  int get totalWorkouts;
  @override
  int get totalDistanceMeters;
  @override
  int get totalDurationSeconds; // Subscription
  @override
  SubscriptionStatus get subscriptionStatus;
  @override
  SubscriptionTier get subscriptionTier;
  @override
  DateTime? get subscriptionExpiresAt;
  @override
  String? get revenuecatCustomerId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
