// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$Challenge {
  String get id => throw _privateConstructorUsedError;
  ChallengeType get challengeType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  WorkoutSportType? get sportType => throw _privateConstructorUsedError;
  double get targetValue => throw _privateConstructorUsedError;
  String get targetUnit => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  bool get isDaily => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  DateTime? get startsAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Progress fields (joined from user_challenge_progress)
  double get progressValue => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this Challenge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call(
      {String id,
      ChallengeType challengeType,
      String title,
      String? description,
      WorkoutSportType? sportType,
      double targetValue,
      String targetUnit,
      int xpReward,
      bool isDaily,
      bool isPremium,
      String? icon,
      DateTime? startsAt,
      DateTime? expiresAt,
      DateTime createdAt,
      double progressValue,
      bool isCompleted,
      DateTime? completedAt});
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeType = null,
    Object? title = null,
    Object? description = freezed,
    Object? sportType = freezed,
    Object? targetValue = null,
    Object? targetUnit = null,
    Object? xpReward = null,
    Object? isDaily = null,
    Object? isPremium = null,
    Object? icon = freezed,
    Object? startsAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? progressValue = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challengeType: null == challengeType
          ? _value.challengeType
          : challengeType // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sportType: freezed == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType?,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      targetUnit: null == targetUnit
          ? _value.targetUnit
          : targetUnit // ignore: cast_nullable_to_non_nullable
              as String,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      isDaily: null == isDaily
          ? _value.isDaily
          : isDaily // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      startsAt: freezed == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progressValue: null == progressValue
          ? _value.progressValue
          : progressValue // ignore: cast_nullable_to_non_nullable
              as double,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
          _$ChallengeImpl value, $Res Function(_$ChallengeImpl) then) =
      __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChallengeType challengeType,
      String title,
      String? description,
      WorkoutSportType? sportType,
      double targetValue,
      String targetUnit,
      int xpReward,
      bool isDaily,
      bool isPremium,
      String? icon,
      DateTime? startsAt,
      DateTime? expiresAt,
      DateTime createdAt,
      double progressValue,
      bool isCompleted,
      DateTime? completedAt});
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
      _$ChallengeImpl _value, $Res Function(_$ChallengeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeType = null,
    Object? title = null,
    Object? description = freezed,
    Object? sportType = freezed,
    Object? targetValue = null,
    Object? targetUnit = null,
    Object? xpReward = null,
    Object? isDaily = null,
    Object? isPremium = null,
    Object? icon = freezed,
    Object? startsAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? progressValue = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challengeType: null == challengeType
          ? _value.challengeType
          : challengeType // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sportType: freezed == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType?,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      targetUnit: null == targetUnit
          ? _value.targetUnit
          : targetUnit // ignore: cast_nullable_to_non_nullable
              as String,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      isDaily: null == isDaily
          ? _value.isDaily
          : isDaily // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      startsAt: freezed == startsAt
          ? _value.startsAt
          : startsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progressValue: null == progressValue
          ? _value.progressValue
          : progressValue // ignore: cast_nullable_to_non_nullable
              as double,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.id,
      required this.challengeType,
      required this.title,
      this.description,
      this.sportType,
      required this.targetValue,
      required this.targetUnit,
      required this.xpReward,
      this.isDaily = true,
      this.isPremium = false,
      this.icon,
      this.startsAt,
      this.expiresAt,
      required this.createdAt,
      this.progressValue = 0,
      this.isCompleted = false,
      this.completedAt});

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final String id;
  @override
  final ChallengeType challengeType;
  @override
  final String title;
  @override
  final String? description;
  @override
  final WorkoutSportType? sportType;
  @override
  final double targetValue;
  @override
  final String targetUnit;
  @override
  final int xpReward;
  @override
  @JsonKey()
  final bool isDaily;
  @override
  @JsonKey()
  final bool isPremium;
  @override
  final String? icon;
  @override
  final DateTime? startsAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime createdAt;
// Progress fields (joined from user_challenge_progress)
  @override
  @JsonKey()
  final double progressValue;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'Challenge(id: $id, challengeType: $challengeType, title: $title, description: $description, sportType: $sportType, targetValue: $targetValue, targetUnit: $targetUnit, xpReward: $xpReward, isDaily: $isDaily, isPremium: $isPremium, icon: $icon, startsAt: $startsAt, expiresAt: $expiresAt, createdAt: $createdAt, progressValue: $progressValue, isCompleted: $isCompleted, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challengeType, challengeType) ||
                other.challengeType == challengeType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sportType, sportType) ||
                other.sportType == sportType) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.targetUnit, targetUnit) ||
                other.targetUnit == targetUnit) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.isDaily, isDaily) || other.isDaily == isDaily) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.progressValue, progressValue) ||
                other.progressValue == progressValue) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      challengeType,
      title,
      description,
      sportType,
      targetValue,
      targetUnit,
      xpReward,
      isDaily,
      isPremium,
      icon,
      startsAt,
      expiresAt,
      createdAt,
      progressValue,
      isCompleted,
      completedAt);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(
      this,
    );
  }
}

abstract class _Challenge implements Challenge {
  const factory _Challenge(
      {required final String id,
      required final ChallengeType challengeType,
      required final String title,
      final String? description,
      final WorkoutSportType? sportType,
      required final double targetValue,
      required final String targetUnit,
      required final int xpReward,
      final bool isDaily,
      final bool isPremium,
      final String? icon,
      final DateTime? startsAt,
      final DateTime? expiresAt,
      required final DateTime createdAt,
      final double progressValue,
      final bool isCompleted,
      final DateTime? completedAt}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  String get id;
  @override
  ChallengeType get challengeType;
  @override
  String get title;
  @override
  String? get description;
  @override
  WorkoutSportType? get sportType;
  @override
  double get targetValue;
  @override
  String get targetUnit;
  @override
  int get xpReward;
  @override
  bool get isDaily;
  @override
  bool get isPremium;
  @override
  String? get icon;
  @override
  DateTime? get startsAt;
  @override
  DateTime? get expiresAt;
  @override
  DateTime
      get createdAt; // Progress fields (joined from user_challenge_progress)
  @override
  double get progressValue;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
