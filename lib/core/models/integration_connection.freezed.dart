// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'integration_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntegrationConnection _$IntegrationConnectionFromJson(
    Map<String, dynamic> json) {
  return _IntegrationConnection.fromJson(json);
}

/// @nodoc
mixin _$IntegrationConnection {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  IntegrationProvider get provider => throw _privateConstructorUsedError;
  bool get isConnected =>
      throw _privateConstructorUsedError; // Note: tokens are NOT returned to client — only metadata
  DateTime? get tokenExpiresAt => throw _privateConstructorUsedError;
  String? get providerUserId => throw _privateConstructorUsedError;
  String? get providerUsername => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;
  String? get lastSyncCursor => throw _privateConstructorUsedError;
  String? get syncError => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this IntegrationConnection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntegrationConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntegrationConnectionCopyWith<IntegrationConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntegrationConnectionCopyWith<$Res> {
  factory $IntegrationConnectionCopyWith(IntegrationConnection value,
          $Res Function(IntegrationConnection) then) =
      _$IntegrationConnectionCopyWithImpl<$Res, IntegrationConnection>;
  @useResult
  $Res call(
      {String id,
      String userId,
      IntegrationProvider provider,
      bool isConnected,
      DateTime? tokenExpiresAt,
      String? providerUserId,
      String? providerUsername,
      DateTime? lastSyncedAt,
      String? lastSyncCursor,
      String? syncError,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$IntegrationConnectionCopyWithImpl<$Res,
        $Val extends IntegrationConnection>
    implements $IntegrationConnectionCopyWith<$Res> {
  _$IntegrationConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntegrationConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? provider = null,
    Object? isConnected = null,
    Object? tokenExpiresAt = freezed,
    Object? providerUserId = freezed,
    Object? providerUsername = freezed,
    Object? lastSyncedAt = freezed,
    Object? lastSyncCursor = freezed,
    Object? syncError = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as IntegrationProvider,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenExpiresAt: freezed == tokenExpiresAt
          ? _value.tokenExpiresAt
          : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      providerUserId: freezed == providerUserId
          ? _value.providerUserId
          : providerUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      providerUsername: freezed == providerUsername
          ? _value.providerUsername
          : providerUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncCursor: freezed == lastSyncCursor
          ? _value.lastSyncCursor
          : lastSyncCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      syncError: freezed == syncError
          ? _value.syncError
          : syncError // ignore: cast_nullable_to_non_nullable
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
abstract class _$$IntegrationConnectionImplCopyWith<$Res>
    implements $IntegrationConnectionCopyWith<$Res> {
  factory _$$IntegrationConnectionImplCopyWith(
          _$IntegrationConnectionImpl value,
          $Res Function(_$IntegrationConnectionImpl) then) =
      __$$IntegrationConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      IntegrationProvider provider,
      bool isConnected,
      DateTime? tokenExpiresAt,
      String? providerUserId,
      String? providerUsername,
      DateTime? lastSyncedAt,
      String? lastSyncCursor,
      String? syncError,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$IntegrationConnectionImplCopyWithImpl<$Res>
    extends _$IntegrationConnectionCopyWithImpl<$Res,
        _$IntegrationConnectionImpl>
    implements _$$IntegrationConnectionImplCopyWith<$Res> {
  __$$IntegrationConnectionImplCopyWithImpl(_$IntegrationConnectionImpl _value,
      $Res Function(_$IntegrationConnectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntegrationConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? provider = null,
    Object? isConnected = null,
    Object? tokenExpiresAt = freezed,
    Object? providerUserId = freezed,
    Object? providerUsername = freezed,
    Object? lastSyncedAt = freezed,
    Object? lastSyncCursor = freezed,
    Object? syncError = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$IntegrationConnectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as IntegrationProvider,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenExpiresAt: freezed == tokenExpiresAt
          ? _value.tokenExpiresAt
          : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      providerUserId: freezed == providerUserId
          ? _value.providerUserId
          : providerUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      providerUsername: freezed == providerUsername
          ? _value.providerUsername
          : providerUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncCursor: freezed == lastSyncCursor
          ? _value.lastSyncCursor
          : lastSyncCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      syncError: freezed == syncError
          ? _value.syncError
          : syncError // ignore: cast_nullable_to_non_nullable
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
class _$IntegrationConnectionImpl implements _IntegrationConnection {
  const _$IntegrationConnectionImpl(
      {required this.id,
      required this.userId,
      required this.provider,
      this.isConnected = false,
      this.tokenExpiresAt,
      this.providerUserId,
      this.providerUsername,
      this.lastSyncedAt,
      this.lastSyncCursor,
      this.syncError,
      required this.createdAt,
      required this.updatedAt});

  factory _$IntegrationConnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntegrationConnectionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final IntegrationProvider provider;
  @override
  @JsonKey()
  final bool isConnected;
// Note: tokens are NOT returned to client — only metadata
  @override
  final DateTime? tokenExpiresAt;
  @override
  final String? providerUserId;
  @override
  final String? providerUsername;
  @override
  final DateTime? lastSyncedAt;
  @override
  final String? lastSyncCursor;
  @override
  final String? syncError;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'IntegrationConnection(id: $id, userId: $userId, provider: $provider, isConnected: $isConnected, tokenExpiresAt: $tokenExpiresAt, providerUserId: $providerUserId, providerUsername: $providerUsername, lastSyncedAt: $lastSyncedAt, lastSyncCursor: $lastSyncCursor, syncError: $syncError, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.tokenExpiresAt, tokenExpiresAt) ||
                other.tokenExpiresAt == tokenExpiresAt) &&
            (identical(other.providerUserId, providerUserId) ||
                other.providerUserId == providerUserId) &&
            (identical(other.providerUsername, providerUsername) ||
                other.providerUsername == providerUsername) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            (identical(other.lastSyncCursor, lastSyncCursor) ||
                other.lastSyncCursor == lastSyncCursor) &&
            (identical(other.syncError, syncError) ||
                other.syncError == syncError) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      provider,
      isConnected,
      tokenExpiresAt,
      providerUserId,
      providerUsername,
      lastSyncedAt,
      lastSyncCursor,
      syncError,
      createdAt,
      updatedAt);

  /// Create a copy of IntegrationConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationConnectionImplCopyWith<_$IntegrationConnectionImpl>
      get copyWith => __$$IntegrationConnectionImplCopyWithImpl<
          _$IntegrationConnectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntegrationConnectionImplToJson(
      this,
    );
  }
}

abstract class _IntegrationConnection implements IntegrationConnection {
  const factory _IntegrationConnection(
      {required final String id,
      required final String userId,
      required final IntegrationProvider provider,
      final bool isConnected,
      final DateTime? tokenExpiresAt,
      final String? providerUserId,
      final String? providerUsername,
      final DateTime? lastSyncedAt,
      final String? lastSyncCursor,
      final String? syncError,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$IntegrationConnectionImpl;

  factory _IntegrationConnection.fromJson(Map<String, dynamic> json) =
      _$IntegrationConnectionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  IntegrationProvider get provider;
  @override
  bool
      get isConnected; // Note: tokens are NOT returned to client — only metadata
  @override
  DateTime? get tokenExpiresAt;
  @override
  String? get providerUserId;
  @override
  String? get providerUsername;
  @override
  DateTime? get lastSyncedAt;
  @override
  String? get lastSyncCursor;
  @override
  String? get syncError;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of IntegrationConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntegrationConnectionImplCopyWith<_$IntegrationConnectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
