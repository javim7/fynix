// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RaceEvent _$RaceEventFromJson(Map<String, dynamic> json) {
  return _RaceEvent.fromJson(json);
}

/// @nodoc
mixin _$RaceEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  WorkoutSportType get sportType => throw _privateConstructorUsedError;
  int? get distanceMeters => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  String? get registrationUrl => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  int get bonusXpReward => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // User registration state (joined)
  bool get isRegistered => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get registeredAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int? get finishTimeSeconds => throw _privateConstructorUsedError;

  /// Serializes this RaceEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RaceEventCopyWith<RaceEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RaceEventCopyWith<$Res> {
  factory $RaceEventCopyWith(RaceEvent value, $Res Function(RaceEvent) then) =
      _$RaceEventCopyWithImpl<$Res, RaceEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      WorkoutSportType sportType,
      int? distanceMeters,
      String? location,
      String? city,
      String country,
      DateTime eventDate,
      String? registrationUrl,
      String? imageUrl,
      int xpReward,
      int bonusXpReward,
      bool isFeatured,
      DateTime createdAt,
      bool isRegistered,
      bool isCompleted,
      DateTime? registeredAt,
      DateTime? completedAt,
      int? finishTimeSeconds});
}

/// @nodoc
class _$RaceEventCopyWithImpl<$Res, $Val extends RaceEvent>
    implements $RaceEventCopyWith<$Res> {
  _$RaceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? sportType = null,
    Object? distanceMeters = freezed,
    Object? location = freezed,
    Object? city = freezed,
    Object? country = null,
    Object? eventDate = null,
    Object? registrationUrl = freezed,
    Object? imageUrl = freezed,
    Object? xpReward = null,
    Object? bonusXpReward = null,
    Object? isFeatured = null,
    Object? createdAt = null,
    Object? isRegistered = null,
    Object? isCompleted = null,
    Object? registeredAt = freezed,
    Object? completedAt = freezed,
    Object? finishTimeSeconds = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType,
      distanceMeters: freezed == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      registrationUrl: freezed == registrationUrl
          ? _value.registrationUrl
          : registrationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      bonusXpReward: null == bonusXpReward
          ? _value.bonusXpReward
          : bonusXpReward // ignore: cast_nullable_to_non_nullable
              as int,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRegistered: null == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      registeredAt: freezed == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishTimeSeconds: freezed == finishTimeSeconds
          ? _value.finishTimeSeconds
          : finishTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RaceEventImplCopyWith<$Res>
    implements $RaceEventCopyWith<$Res> {
  factory _$$RaceEventImplCopyWith(
          _$RaceEventImpl value, $Res Function(_$RaceEventImpl) then) =
      __$$RaceEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      WorkoutSportType sportType,
      int? distanceMeters,
      String? location,
      String? city,
      String country,
      DateTime eventDate,
      String? registrationUrl,
      String? imageUrl,
      int xpReward,
      int bonusXpReward,
      bool isFeatured,
      DateTime createdAt,
      bool isRegistered,
      bool isCompleted,
      DateTime? registeredAt,
      DateTime? completedAt,
      int? finishTimeSeconds});
}

/// @nodoc
class __$$RaceEventImplCopyWithImpl<$Res>
    extends _$RaceEventCopyWithImpl<$Res, _$RaceEventImpl>
    implements _$$RaceEventImplCopyWith<$Res> {
  __$$RaceEventImplCopyWithImpl(
      _$RaceEventImpl _value, $Res Function(_$RaceEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of RaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? sportType = null,
    Object? distanceMeters = freezed,
    Object? location = freezed,
    Object? city = freezed,
    Object? country = null,
    Object? eventDate = null,
    Object? registrationUrl = freezed,
    Object? imageUrl = freezed,
    Object? xpReward = null,
    Object? bonusXpReward = null,
    Object? isFeatured = null,
    Object? createdAt = null,
    Object? isRegistered = null,
    Object? isCompleted = null,
    Object? registeredAt = freezed,
    Object? completedAt = freezed,
    Object? finishTimeSeconds = freezed,
  }) {
    return _then(_$RaceEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType,
      distanceMeters: freezed == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      registrationUrl: freezed == registrationUrl
          ? _value.registrationUrl
          : registrationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      bonusXpReward: null == bonusXpReward
          ? _value.bonusXpReward
          : bonusXpReward // ignore: cast_nullable_to_non_nullable
              as int,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRegistered: null == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      registeredAt: freezed == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishTimeSeconds: freezed == finishTimeSeconds
          ? _value.finishTimeSeconds
          : finishTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RaceEventImpl implements _RaceEvent {
  const _$RaceEventImpl(
      {required this.id,
      required this.title,
      this.description,
      this.sportType = WorkoutSportType.running,
      this.distanceMeters,
      this.location,
      this.city,
      this.country = 'GT',
      required this.eventDate,
      this.registrationUrl,
      this.imageUrl,
      this.xpReward = 0,
      this.bonusXpReward = 0,
      this.isFeatured = false,
      required this.createdAt,
      this.isRegistered = false,
      this.isCompleted = false,
      this.registeredAt,
      this.completedAt,
      this.finishTimeSeconds});

  factory _$RaceEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$RaceEventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final WorkoutSportType sportType;
  @override
  final int? distanceMeters;
  @override
  final String? location;
  @override
  final String? city;
  @override
  @JsonKey()
  final String country;
  @override
  final DateTime eventDate;
  @override
  final String? registrationUrl;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int xpReward;
  @override
  @JsonKey()
  final int bonusXpReward;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  final DateTime createdAt;
// User registration state (joined)
  @override
  @JsonKey()
  final bool isRegistered;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? registeredAt;
  @override
  final DateTime? completedAt;
  @override
  final int? finishTimeSeconds;

  @override
  String toString() {
    return 'RaceEvent(id: $id, title: $title, description: $description, sportType: $sportType, distanceMeters: $distanceMeters, location: $location, city: $city, country: $country, eventDate: $eventDate, registrationUrl: $registrationUrl, imageUrl: $imageUrl, xpReward: $xpReward, bonusXpReward: $bonusXpReward, isFeatured: $isFeatured, createdAt: $createdAt, isRegistered: $isRegistered, isCompleted: $isCompleted, registeredAt: $registeredAt, completedAt: $completedAt, finishTimeSeconds: $finishTimeSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RaceEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sportType, sportType) ||
                other.sportType == sportType) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.registrationUrl, registrationUrl) ||
                other.registrationUrl == registrationUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.bonusXpReward, bonusXpReward) ||
                other.bonusXpReward == bonusXpReward) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.finishTimeSeconds, finishTimeSeconds) ||
                other.finishTimeSeconds == finishTimeSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        sportType,
        distanceMeters,
        location,
        city,
        country,
        eventDate,
        registrationUrl,
        imageUrl,
        xpReward,
        bonusXpReward,
        isFeatured,
        createdAt,
        isRegistered,
        isCompleted,
        registeredAt,
        completedAt,
        finishTimeSeconds
      ]);

  /// Create a copy of RaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RaceEventImplCopyWith<_$RaceEventImpl> get copyWith =>
      __$$RaceEventImplCopyWithImpl<_$RaceEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RaceEventImplToJson(
      this,
    );
  }
}

abstract class _RaceEvent implements RaceEvent {
  const factory _RaceEvent(
      {required final String id,
      required final String title,
      final String? description,
      final WorkoutSportType sportType,
      final int? distanceMeters,
      final String? location,
      final String? city,
      final String country,
      required final DateTime eventDate,
      final String? registrationUrl,
      final String? imageUrl,
      final int xpReward,
      final int bonusXpReward,
      final bool isFeatured,
      required final DateTime createdAt,
      final bool isRegistered,
      final bool isCompleted,
      final DateTime? registeredAt,
      final DateTime? completedAt,
      final int? finishTimeSeconds}) = _$RaceEventImpl;

  factory _RaceEvent.fromJson(Map<String, dynamic> json) =
      _$RaceEventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  WorkoutSportType get sportType;
  @override
  int? get distanceMeters;
  @override
  String? get location;
  @override
  String? get city;
  @override
  String get country;
  @override
  DateTime get eventDate;
  @override
  String? get registrationUrl;
  @override
  String? get imageUrl;
  @override
  int get xpReward;
  @override
  int get bonusXpReward;
  @override
  bool get isFeatured;
  @override
  DateTime get createdAt; // User registration state (joined)
  @override
  bool get isRegistered;
  @override
  bool get isCompleted;
  @override
  DateTime? get registeredAt;
  @override
  DateTime? get completedAt;
  @override
  int? get finishTimeSeconds;

  /// Create a copy of RaceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RaceEventImplCopyWith<_$RaceEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
