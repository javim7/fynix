// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xp_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

XpEvent _$XpEventFromJson(Map<String, dynamic> json) {
  return _XpEvent.fromJson(json);
}

/// @nodoc
mixin _$XpEvent {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  XpSource get source => throw _privateConstructorUsedError;
  int get xpAmount => throw _privateConstructorUsedError;
  String get description =>
      throw _privateConstructorUsedError; // Optional foreign keys (only one set per event)
  String? get workoutId => throw _privateConstructorUsedError;
  String? get challengeId => throw _privateConstructorUsedError;
  String? get badgeId => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this XpEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of XpEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $XpEventCopyWith<XpEvent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XpEventCopyWith<$Res> {
  factory $XpEventCopyWith(XpEvent value, $Res Function(XpEvent) then) =
      _$XpEventCopyWithImpl<$Res, XpEvent>;
  @useResult
  $Res call(
      {String id,
      String userId,
      XpSource source,
      int xpAmount,
      String description,
      String? workoutId,
      String? challengeId,
      String? badgeId,
      String? eventId,
      Map<String, dynamic>? metadata,
      DateTime createdAt});
}

/// @nodoc
class _$XpEventCopyWithImpl<$Res, $Val extends XpEvent>
    implements $XpEventCopyWith<$Res> {
  _$XpEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of XpEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? source = null,
    Object? xpAmount = null,
    Object? description = null,
    Object? workoutId = freezed,
    Object? challengeId = freezed,
    Object? badgeId = freezed,
    Object? eventId = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as XpSource,
      xpAmount: null == xpAmount
          ? _value.xpAmount
          : xpAmount // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: freezed == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      challengeId: freezed == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String?,
      badgeId: freezed == badgeId
          ? _value.badgeId
          : badgeId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XpEventImplCopyWith<$Res> implements $XpEventCopyWith<$Res> {
  factory _$$XpEventImplCopyWith(
          _$XpEventImpl value, $Res Function(_$XpEventImpl) then) =
      __$$XpEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      XpSource source,
      int xpAmount,
      String description,
      String? workoutId,
      String? challengeId,
      String? badgeId,
      String? eventId,
      Map<String, dynamic>? metadata,
      DateTime createdAt});
}

/// @nodoc
class __$$XpEventImplCopyWithImpl<$Res>
    extends _$XpEventCopyWithImpl<$Res, _$XpEventImpl>
    implements _$$XpEventImplCopyWith<$Res> {
  __$$XpEventImplCopyWithImpl(
      _$XpEventImpl _value, $Res Function(_$XpEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of XpEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? source = null,
    Object? xpAmount = null,
    Object? description = null,
    Object? workoutId = freezed,
    Object? challengeId = freezed,
    Object? badgeId = freezed,
    Object? eventId = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$XpEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as XpSource,
      xpAmount: null == xpAmount
          ? _value.xpAmount
          : xpAmount // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: freezed == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      challengeId: freezed == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String?,
      badgeId: freezed == badgeId
          ? _value.badgeId
          : badgeId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XpEventImpl implements _XpEvent {
  const _$XpEventImpl(
      {required this.id,
      required this.userId,
      required this.source,
      required this.xpAmount,
      required this.description,
      this.workoutId,
      this.challengeId,
      this.badgeId,
      this.eventId,
      final Map<String, dynamic>? metadata,
      required this.createdAt})
      : _metadata = metadata;

  factory _$XpEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$XpEventImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final XpSource source;
  @override
  final int xpAmount;
  @override
  final String description;
// Optional foreign keys (only one set per event)
  @override
  final String? workoutId;
  @override
  final String? challengeId;
  @override
  final String? badgeId;
  @override
  final String? eventId;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'XpEvent(id: $id, userId: $userId, source: $source, xpAmount: $xpAmount, description: $description, workoutId: $workoutId, challengeId: $challengeId, badgeId: $badgeId, eventId: $eventId, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XpEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.xpAmount, xpAmount) ||
                other.xpAmount == xpAmount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      source,
      xpAmount,
      description,
      workoutId,
      challengeId,
      badgeId,
      eventId,
      const DeepCollectionEquality().hash(_metadata),
      createdAt);

  /// Create a copy of XpEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$XpEventImplCopyWith<_$XpEventImpl> get copyWith =>
      __$$XpEventImplCopyWithImpl<_$XpEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XpEventImplToJson(
      this,
    );
  }
}

abstract class _XpEvent implements XpEvent {
  const factory _XpEvent(
      {required final String id,
      required final String userId,
      required final XpSource source,
      required final int xpAmount,
      required final String description,
      final String? workoutId,
      final String? challengeId,
      final String? badgeId,
      final String? eventId,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt}) = _$XpEventImpl;

  factory _XpEvent.fromJson(Map<String, dynamic> json) = _$XpEventImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  XpSource get source;
  @override
  int get xpAmount;
  @override
  String get description; // Optional foreign keys (only one set per event)
  @override
  String? get workoutId;
  @override
  String? get challengeId;
  @override
  String? get badgeId;
  @override
  String? get eventId;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get createdAt;

  /// Create a copy of XpEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$XpEventImplCopyWith<_$XpEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
