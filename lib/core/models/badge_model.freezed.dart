// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BadgeModel _$BadgeModelFromJson(Map<String, dynamic> json) {
  return _BadgeModel.fromJson(json);
}

/// @nodoc
mixin _$BadgeModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get iconAsset => throw _privateConstructorUsedError;
  String get conditionType => throw _privateConstructorUsedError;
  WorkoutSportType? get conditionSport => throw _privateConstructorUsedError;
  double get conditionValue => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Unlock state (populated when loaded for a specific user)
  bool get isUnlocked => throw _privateConstructorUsedError;
  DateTime? get unlockedAt => throw _privateConstructorUsedError;

  /// Serializes this BadgeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeModelCopyWith<BadgeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeModelCopyWith<$Res> {
  factory $BadgeModelCopyWith(
          BadgeModel value, $Res Function(BadgeModel) then) =
      _$BadgeModelCopyWithImpl<$Res, BadgeModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String iconAsset,
      String conditionType,
      WorkoutSportType? conditionSport,
      double conditionValue,
      int xpReward,
      bool isPremium,
      int sortOrder,
      DateTime createdAt,
      bool isUnlocked,
      DateTime? unlockedAt});
}

/// @nodoc
class _$BadgeModelCopyWithImpl<$Res, $Val extends BadgeModel>
    implements $BadgeModelCopyWith<$Res> {
  _$BadgeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconAsset = null,
    Object? conditionType = null,
    Object? conditionSport = freezed,
    Object? conditionValue = null,
    Object? xpReward = null,
    Object? isPremium = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconAsset: null == iconAsset
          ? _value.iconAsset
          : iconAsset // ignore: cast_nullable_to_non_nullable
              as String,
      conditionType: null == conditionType
          ? _value.conditionType
          : conditionType // ignore: cast_nullable_to_non_nullable
              as String,
      conditionSport: freezed == conditionSport
          ? _value.conditionSport
          : conditionSport // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType?,
      conditionValue: null == conditionValue
          ? _value.conditionValue
          : conditionValue // ignore: cast_nullable_to_non_nullable
              as double,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BadgeModelImplCopyWith<$Res>
    implements $BadgeModelCopyWith<$Res> {
  factory _$$BadgeModelImplCopyWith(
          _$BadgeModelImpl value, $Res Function(_$BadgeModelImpl) then) =
      __$$BadgeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String iconAsset,
      String conditionType,
      WorkoutSportType? conditionSport,
      double conditionValue,
      int xpReward,
      bool isPremium,
      int sortOrder,
      DateTime createdAt,
      bool isUnlocked,
      DateTime? unlockedAt});
}

/// @nodoc
class __$$BadgeModelImplCopyWithImpl<$Res>
    extends _$BadgeModelCopyWithImpl<$Res, _$BadgeModelImpl>
    implements _$$BadgeModelImplCopyWith<$Res> {
  __$$BadgeModelImplCopyWithImpl(
      _$BadgeModelImpl _value, $Res Function(_$BadgeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconAsset = null,
    Object? conditionType = null,
    Object? conditionSport = freezed,
    Object? conditionValue = null,
    Object? xpReward = null,
    Object? isPremium = null,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
  }) {
    return _then(_$BadgeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconAsset: null == iconAsset
          ? _value.iconAsset
          : iconAsset // ignore: cast_nullable_to_non_nullable
              as String,
      conditionType: null == conditionType
          ? _value.conditionType
          : conditionType // ignore: cast_nullable_to_non_nullable
              as String,
      conditionSport: freezed == conditionSport
          ? _value.conditionSport
          : conditionSport // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType?,
      conditionValue: null == conditionValue
          ? _value.conditionValue
          : conditionValue // ignore: cast_nullable_to_non_nullable
              as double,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeModelImpl implements _BadgeModel {
  const _$BadgeModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.iconAsset,
      required this.conditionType,
      this.conditionSport,
      required this.conditionValue,
      this.xpReward = 0,
      this.isPremium = false,
      this.sortOrder = 0,
      required this.createdAt,
      this.isUnlocked = false,
      this.unlockedAt});

  factory _$BadgeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String iconAsset;
  @override
  final String conditionType;
  @override
  final WorkoutSportType? conditionSport;
  @override
  final double conditionValue;
  @override
  @JsonKey()
  final int xpReward;
  @override
  @JsonKey()
  final bool isPremium;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  final DateTime createdAt;
// Unlock state (populated when loaded for a specific user)
  @override
  @JsonKey()
  final bool isUnlocked;
  @override
  final DateTime? unlockedAt;

  @override
  String toString() {
    return 'BadgeModel(id: $id, title: $title, description: $description, iconAsset: $iconAsset, conditionType: $conditionType, conditionSport: $conditionSport, conditionValue: $conditionValue, xpReward: $xpReward, isPremium: $isPremium, sortOrder: $sortOrder, createdAt: $createdAt, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconAsset, iconAsset) ||
                other.iconAsset == iconAsset) &&
            (identical(other.conditionType, conditionType) ||
                other.conditionType == conditionType) &&
            (identical(other.conditionSport, conditionSport) ||
                other.conditionSport == conditionSport) &&
            (identical(other.conditionValue, conditionValue) ||
                other.conditionValue == conditionValue) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      iconAsset,
      conditionType,
      conditionSport,
      conditionValue,
      xpReward,
      isPremium,
      sortOrder,
      createdAt,
      isUnlocked,
      unlockedAt);

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeModelImplCopyWith<_$BadgeModelImpl> get copyWith =>
      __$$BadgeModelImplCopyWithImpl<_$BadgeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeModelImplToJson(
      this,
    );
  }
}

abstract class _BadgeModel implements BadgeModel {
  const factory _BadgeModel(
      {required final String id,
      required final String title,
      required final String description,
      required final String iconAsset,
      required final String conditionType,
      final WorkoutSportType? conditionSport,
      required final double conditionValue,
      final int xpReward,
      final bool isPremium,
      final int sortOrder,
      required final DateTime createdAt,
      final bool isUnlocked,
      final DateTime? unlockedAt}) = _$BadgeModelImpl;

  factory _BadgeModel.fromJson(Map<String, dynamic> json) =
      _$BadgeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get iconAsset;
  @override
  String get conditionType;
  @override
  WorkoutSportType? get conditionSport;
  @override
  double get conditionValue;
  @override
  int get xpReward;
  @override
  bool get isPremium;
  @override
  int get sortOrder;
  @override
  DateTime
      get createdAt; // Unlock state (populated when loaded for a specific user)
  @override
  bool get isUnlocked;
  @override
  DateTime? get unlockedAt;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeModelImplCopyWith<_$BadgeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
