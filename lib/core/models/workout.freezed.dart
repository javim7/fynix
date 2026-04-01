// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkoutSplit _$WorkoutSplitFromJson(Map<String, dynamic> json) {
  return _WorkoutSplit.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSplit {
  double get distanceMeters => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  double? get paceSecondsPerKm => throw _privateConstructorUsedError;

  /// Serializes this WorkoutSplit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSplit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSplitCopyWith<WorkoutSplit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSplitCopyWith<$Res> {
  factory $WorkoutSplitCopyWith(
          WorkoutSplit value, $Res Function(WorkoutSplit) then) =
      _$WorkoutSplitCopyWithImpl<$Res, WorkoutSplit>;
  @useResult
  $Res call(
      {double distanceMeters, int durationSeconds, double? paceSecondsPerKm});
}

/// @nodoc
class _$WorkoutSplitCopyWithImpl<$Res, $Val extends WorkoutSplit>
    implements $WorkoutSplitCopyWith<$Res> {
  _$WorkoutSplitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSplit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? paceSecondsPerKm = freezed,
  }) {
    return _then(_value.copyWith(
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      paceSecondsPerKm: freezed == paceSecondsPerKm
          ? _value.paceSecondsPerKm
          : paceSecondsPerKm // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSplitImplCopyWith<$Res>
    implements $WorkoutSplitCopyWith<$Res> {
  factory _$$WorkoutSplitImplCopyWith(
          _$WorkoutSplitImpl value, $Res Function(_$WorkoutSplitImpl) then) =
      __$$WorkoutSplitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double distanceMeters, int durationSeconds, double? paceSecondsPerKm});
}

/// @nodoc
class __$$WorkoutSplitImplCopyWithImpl<$Res>
    extends _$WorkoutSplitCopyWithImpl<$Res, _$WorkoutSplitImpl>
    implements _$$WorkoutSplitImplCopyWith<$Res> {
  __$$WorkoutSplitImplCopyWithImpl(
      _$WorkoutSplitImpl _value, $Res Function(_$WorkoutSplitImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSplit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? paceSecondsPerKm = freezed,
  }) {
    return _then(_$WorkoutSplitImpl(
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      paceSecondsPerKm: freezed == paceSecondsPerKm
          ? _value.paceSecondsPerKm
          : paceSecondsPerKm // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutSplitImpl implements _WorkoutSplit {
  const _$WorkoutSplitImpl(
      {required this.distanceMeters,
      required this.durationSeconds,
      this.paceSecondsPerKm});

  factory _$WorkoutSplitImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSplitImplFromJson(json);

  @override
  final double distanceMeters;
  @override
  final int durationSeconds;
  @override
  final double? paceSecondsPerKm;

  @override
  String toString() {
    return 'WorkoutSplit(distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, paceSecondsPerKm: $paceSecondsPerKm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSplitImpl &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.paceSecondsPerKm, paceSecondsPerKm) ||
                other.paceSecondsPerKm == paceSecondsPerKm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, distanceMeters, durationSeconds, paceSecondsPerKm);

  /// Create a copy of WorkoutSplit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSplitImplCopyWith<_$WorkoutSplitImpl> get copyWith =>
      __$$WorkoutSplitImplCopyWithImpl<_$WorkoutSplitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSplitImplToJson(
      this,
    );
  }
}

abstract class _WorkoutSplit implements WorkoutSplit {
  const factory _WorkoutSplit(
      {required final double distanceMeters,
      required final int durationSeconds,
      final double? paceSecondsPerKm}) = _$WorkoutSplitImpl;

  factory _WorkoutSplit.fromJson(Map<String, dynamic> json) =
      _$WorkoutSplitImpl.fromJson;

  @override
  double get distanceMeters;
  @override
  int get durationSeconds;
  @override
  double? get paceSecondsPerKm;

  /// Create a copy of WorkoutSplit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSplitImplCopyWith<_$WorkoutSplitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

XpBreakdownData _$XpBreakdownDataFromJson(Map<String, dynamic> json) {
  return _XpBreakdownData.fromJson(json);
}

/// @nodoc
mixin _$XpBreakdownData {
  int get baseXp => throw _privateConstructorUsedError;
  int get streakBonus => throw _privateConstructorUsedError;
  int get prBonus => throw _privateConstructorUsedError;
  int get morningBonus => throw _privateConstructorUsedError;
  int get challengeBonus => throw _privateConstructorUsedError;
  int get eventBonus => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  double? get ratePerKm => throw _privateConstructorUsedError;
  double? get distanceKm => throw _privateConstructorUsedError;
  String? get sport => throw _privateConstructorUsedError;

  /// Serializes this XpBreakdownData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of XpBreakdownData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $XpBreakdownDataCopyWith<XpBreakdownData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XpBreakdownDataCopyWith<$Res> {
  factory $XpBreakdownDataCopyWith(
          XpBreakdownData value, $Res Function(XpBreakdownData) then) =
      _$XpBreakdownDataCopyWithImpl<$Res, XpBreakdownData>;
  @useResult
  $Res call(
      {int baseXp,
      int streakBonus,
      int prBonus,
      int morningBonus,
      int challengeBonus,
      int eventBonus,
      int total,
      double? ratePerKm,
      double? distanceKm,
      String? sport});
}

/// @nodoc
class _$XpBreakdownDataCopyWithImpl<$Res, $Val extends XpBreakdownData>
    implements $XpBreakdownDataCopyWith<$Res> {
  _$XpBreakdownDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of XpBreakdownData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseXp = null,
    Object? streakBonus = null,
    Object? prBonus = null,
    Object? morningBonus = null,
    Object? challengeBonus = null,
    Object? eventBonus = null,
    Object? total = null,
    Object? ratePerKm = freezed,
    Object? distanceKm = freezed,
    Object? sport = freezed,
  }) {
    return _then(_value.copyWith(
      baseXp: null == baseXp
          ? _value.baseXp
          : baseXp // ignore: cast_nullable_to_non_nullable
              as int,
      streakBonus: null == streakBonus
          ? _value.streakBonus
          : streakBonus // ignore: cast_nullable_to_non_nullable
              as int,
      prBonus: null == prBonus
          ? _value.prBonus
          : prBonus // ignore: cast_nullable_to_non_nullable
              as int,
      morningBonus: null == morningBonus
          ? _value.morningBonus
          : morningBonus // ignore: cast_nullable_to_non_nullable
              as int,
      challengeBonus: null == challengeBonus
          ? _value.challengeBonus
          : challengeBonus // ignore: cast_nullable_to_non_nullable
              as int,
      eventBonus: null == eventBonus
          ? _value.eventBonus
          : eventBonus // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      ratePerKm: freezed == ratePerKm
          ? _value.ratePerKm
          : ratePerKm // ignore: cast_nullable_to_non_nullable
              as double?,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double?,
      sport: freezed == sport
          ? _value.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XpBreakdownDataImplCopyWith<$Res>
    implements $XpBreakdownDataCopyWith<$Res> {
  factory _$$XpBreakdownDataImplCopyWith(_$XpBreakdownDataImpl value,
          $Res Function(_$XpBreakdownDataImpl) then) =
      __$$XpBreakdownDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int baseXp,
      int streakBonus,
      int prBonus,
      int morningBonus,
      int challengeBonus,
      int eventBonus,
      int total,
      double? ratePerKm,
      double? distanceKm,
      String? sport});
}

/// @nodoc
class __$$XpBreakdownDataImplCopyWithImpl<$Res>
    extends _$XpBreakdownDataCopyWithImpl<$Res, _$XpBreakdownDataImpl>
    implements _$$XpBreakdownDataImplCopyWith<$Res> {
  __$$XpBreakdownDataImplCopyWithImpl(
      _$XpBreakdownDataImpl _value, $Res Function(_$XpBreakdownDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of XpBreakdownData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseXp = null,
    Object? streakBonus = null,
    Object? prBonus = null,
    Object? morningBonus = null,
    Object? challengeBonus = null,
    Object? eventBonus = null,
    Object? total = null,
    Object? ratePerKm = freezed,
    Object? distanceKm = freezed,
    Object? sport = freezed,
  }) {
    return _then(_$XpBreakdownDataImpl(
      baseXp: null == baseXp
          ? _value.baseXp
          : baseXp // ignore: cast_nullable_to_non_nullable
              as int,
      streakBonus: null == streakBonus
          ? _value.streakBonus
          : streakBonus // ignore: cast_nullable_to_non_nullable
              as int,
      prBonus: null == prBonus
          ? _value.prBonus
          : prBonus // ignore: cast_nullable_to_non_nullable
              as int,
      morningBonus: null == morningBonus
          ? _value.morningBonus
          : morningBonus // ignore: cast_nullable_to_non_nullable
              as int,
      challengeBonus: null == challengeBonus
          ? _value.challengeBonus
          : challengeBonus // ignore: cast_nullable_to_non_nullable
              as int,
      eventBonus: null == eventBonus
          ? _value.eventBonus
          : eventBonus // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      ratePerKm: freezed == ratePerKm
          ? _value.ratePerKm
          : ratePerKm // ignore: cast_nullable_to_non_nullable
              as double?,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double?,
      sport: freezed == sport
          ? _value.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XpBreakdownDataImpl implements _XpBreakdownData {
  const _$XpBreakdownDataImpl(
      {required this.baseXp,
      this.streakBonus = 0,
      this.prBonus = 0,
      this.morningBonus = 0,
      this.challengeBonus = 0,
      this.eventBonus = 0,
      required this.total,
      this.ratePerKm,
      this.distanceKm,
      this.sport});

  factory _$XpBreakdownDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$XpBreakdownDataImplFromJson(json);

  @override
  final int baseXp;
  @override
  @JsonKey()
  final int streakBonus;
  @override
  @JsonKey()
  final int prBonus;
  @override
  @JsonKey()
  final int morningBonus;
  @override
  @JsonKey()
  final int challengeBonus;
  @override
  @JsonKey()
  final int eventBonus;
  @override
  final int total;
  @override
  final double? ratePerKm;
  @override
  final double? distanceKm;
  @override
  final String? sport;

  @override
  String toString() {
    return 'XpBreakdownData(baseXp: $baseXp, streakBonus: $streakBonus, prBonus: $prBonus, morningBonus: $morningBonus, challengeBonus: $challengeBonus, eventBonus: $eventBonus, total: $total, ratePerKm: $ratePerKm, distanceKm: $distanceKm, sport: $sport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XpBreakdownDataImpl &&
            (identical(other.baseXp, baseXp) || other.baseXp == baseXp) &&
            (identical(other.streakBonus, streakBonus) ||
                other.streakBonus == streakBonus) &&
            (identical(other.prBonus, prBonus) || other.prBonus == prBonus) &&
            (identical(other.morningBonus, morningBonus) ||
                other.morningBonus == morningBonus) &&
            (identical(other.challengeBonus, challengeBonus) ||
                other.challengeBonus == challengeBonus) &&
            (identical(other.eventBonus, eventBonus) ||
                other.eventBonus == eventBonus) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.ratePerKm, ratePerKm) ||
                other.ratePerKm == ratePerKm) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.sport, sport) || other.sport == sport));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      baseXp,
      streakBonus,
      prBonus,
      morningBonus,
      challengeBonus,
      eventBonus,
      total,
      ratePerKm,
      distanceKm,
      sport);

  /// Create a copy of XpBreakdownData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$XpBreakdownDataImplCopyWith<_$XpBreakdownDataImpl> get copyWith =>
      __$$XpBreakdownDataImplCopyWithImpl<_$XpBreakdownDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XpBreakdownDataImplToJson(
      this,
    );
  }
}

abstract class _XpBreakdownData implements XpBreakdownData {
  const factory _XpBreakdownData(
      {required final int baseXp,
      final int streakBonus,
      final int prBonus,
      final int morningBonus,
      final int challengeBonus,
      final int eventBonus,
      required final int total,
      final double? ratePerKm,
      final double? distanceKm,
      final String? sport}) = _$XpBreakdownDataImpl;

  factory _XpBreakdownData.fromJson(Map<String, dynamic> json) =
      _$XpBreakdownDataImpl.fromJson;

  @override
  int get baseXp;
  @override
  int get streakBonus;
  @override
  int get prBonus;
  @override
  int get morningBonus;
  @override
  int get challengeBonus;
  @override
  int get eventBonus;
  @override
  int get total;
  @override
  double? get ratePerKm;
  @override
  double? get distanceKm;
  @override
  String? get sport;

  /// Create a copy of XpBreakdownData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$XpBreakdownDataImplCopyWith<_$XpBreakdownDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return _Workout.fromJson(json);
}

/// @nodoc
mixin _$Workout {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get integrationId => throw _privateConstructorUsedError;
  IntegrationProvider? get provider => throw _privateConstructorUsedError;
  String? get providerActivityId => throw _privateConstructorUsedError;
  WorkoutSportType get sportType => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  double? get avgPaceSecondsPerKm => throw _privateConstructorUsedError;
  double? get avgSpeedKmh => throw _privateConstructorUsedError;
  double? get maxSpeedKmh => throw _privateConstructorUsedError;
  double get elevationGainMeters => throw _privateConstructorUsedError;
  double get elevationLossMeters => throw _privateConstructorUsedError;
  int? get avgHeartRate => throw _privateConstructorUsedError;
  int? get maxHeartRate => throw _privateConstructorUsedError;
  int? get calories => throw _privateConstructorUsedError;
  String? get polyline => throw _privateConstructorUsedError;
  String? get mapSnapshotUrl => throw _privateConstructorUsedError;
  List<WorkoutSplit> get splits => throw _privateConstructorUsedError;
  int get xpEarned => throw _privateConstructorUsedError;
  XpBreakdownData? get xpBreakdown => throw _privateConstructorUsedError;
  bool get isDuplicate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Workout to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutCopyWith<Workout> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutCopyWith<$Res> {
  factory $WorkoutCopyWith(Workout value, $Res Function(Workout) then) =
      _$WorkoutCopyWithImpl<$Res, Workout>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? integrationId,
      IntegrationProvider? provider,
      String? providerActivityId,
      WorkoutSportType sportType,
      String? name,
      String? description,
      DateTime startedAt,
      DateTime? endedAt,
      int durationSeconds,
      double distanceMeters,
      double? avgPaceSecondsPerKm,
      double? avgSpeedKmh,
      double? maxSpeedKmh,
      double elevationGainMeters,
      double elevationLossMeters,
      int? avgHeartRate,
      int? maxHeartRate,
      int? calories,
      String? polyline,
      String? mapSnapshotUrl,
      List<WorkoutSplit> splits,
      int xpEarned,
      XpBreakdownData? xpBreakdown,
      bool isDuplicate,
      DateTime createdAt,
      DateTime updatedAt});

  $XpBreakdownDataCopyWith<$Res>? get xpBreakdown;
}

/// @nodoc
class _$WorkoutCopyWithImpl<$Res, $Val extends Workout>
    implements $WorkoutCopyWith<$Res> {
  _$WorkoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? integrationId = freezed,
    Object? provider = freezed,
    Object? providerActivityId = freezed,
    Object? sportType = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? durationSeconds = null,
    Object? distanceMeters = null,
    Object? avgPaceSecondsPerKm = freezed,
    Object? avgSpeedKmh = freezed,
    Object? maxSpeedKmh = freezed,
    Object? elevationGainMeters = null,
    Object? elevationLossMeters = null,
    Object? avgHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? calories = freezed,
    Object? polyline = freezed,
    Object? mapSnapshotUrl = freezed,
    Object? splits = null,
    Object? xpEarned = null,
    Object? xpBreakdown = freezed,
    Object? isDuplicate = null,
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
      integrationId: freezed == integrationId
          ? _value.integrationId
          : integrationId // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as IntegrationProvider?,
      providerActivityId: freezed == providerActivityId
          ? _value.providerActivityId
          : providerActivityId // ignore: cast_nullable_to_non_nullable
              as String?,
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      avgPaceSecondsPerKm: freezed == avgPaceSecondsPerKm
          ? _value.avgPaceSecondsPerKm
          : avgPaceSecondsPerKm // ignore: cast_nullable_to_non_nullable
              as double?,
      avgSpeedKmh: freezed == avgSpeedKmh
          ? _value.avgSpeedKmh
          : avgSpeedKmh // ignore: cast_nullable_to_non_nullable
              as double?,
      maxSpeedKmh: freezed == maxSpeedKmh
          ? _value.maxSpeedKmh
          : maxSpeedKmh // ignore: cast_nullable_to_non_nullable
              as double?,
      elevationGainMeters: null == elevationGainMeters
          ? _value.elevationGainMeters
          : elevationGainMeters // ignore: cast_nullable_to_non_nullable
              as double,
      elevationLossMeters: null == elevationLossMeters
          ? _value.elevationLossMeters
          : elevationLossMeters // ignore: cast_nullable_to_non_nullable
              as double,
      avgHeartRate: freezed == avgHeartRate
          ? _value.avgHeartRate
          : avgHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      polyline: freezed == polyline
          ? _value.polyline
          : polyline // ignore: cast_nullable_to_non_nullable
              as String?,
      mapSnapshotUrl: freezed == mapSnapshotUrl
          ? _value.mapSnapshotUrl
          : mapSnapshotUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      splits: null == splits
          ? _value.splits
          : splits // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSplit>,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      xpBreakdown: freezed == xpBreakdown
          ? _value.xpBreakdown
          : xpBreakdown // ignore: cast_nullable_to_non_nullable
              as XpBreakdownData?,
      isDuplicate: null == isDuplicate
          ? _value.isDuplicate
          : isDuplicate // ignore: cast_nullable_to_non_nullable
              as bool,
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

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $XpBreakdownDataCopyWith<$Res>? get xpBreakdown {
    if (_value.xpBreakdown == null) {
      return null;
    }

    return $XpBreakdownDataCopyWith<$Res>(_value.xpBreakdown!, (value) {
      return _then(_value.copyWith(xpBreakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutImplCopyWith<$Res> implements $WorkoutCopyWith<$Res> {
  factory _$$WorkoutImplCopyWith(
          _$WorkoutImpl value, $Res Function(_$WorkoutImpl) then) =
      __$$WorkoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? integrationId,
      IntegrationProvider? provider,
      String? providerActivityId,
      WorkoutSportType sportType,
      String? name,
      String? description,
      DateTime startedAt,
      DateTime? endedAt,
      int durationSeconds,
      double distanceMeters,
      double? avgPaceSecondsPerKm,
      double? avgSpeedKmh,
      double? maxSpeedKmh,
      double elevationGainMeters,
      double elevationLossMeters,
      int? avgHeartRate,
      int? maxHeartRate,
      int? calories,
      String? polyline,
      String? mapSnapshotUrl,
      List<WorkoutSplit> splits,
      int xpEarned,
      XpBreakdownData? xpBreakdown,
      bool isDuplicate,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $XpBreakdownDataCopyWith<$Res>? get xpBreakdown;
}

/// @nodoc
class __$$WorkoutImplCopyWithImpl<$Res>
    extends _$WorkoutCopyWithImpl<$Res, _$WorkoutImpl>
    implements _$$WorkoutImplCopyWith<$Res> {
  __$$WorkoutImplCopyWithImpl(
      _$WorkoutImpl _value, $Res Function(_$WorkoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? integrationId = freezed,
    Object? provider = freezed,
    Object? providerActivityId = freezed,
    Object? sportType = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? durationSeconds = null,
    Object? distanceMeters = null,
    Object? avgPaceSecondsPerKm = freezed,
    Object? avgSpeedKmh = freezed,
    Object? maxSpeedKmh = freezed,
    Object? elevationGainMeters = null,
    Object? elevationLossMeters = null,
    Object? avgHeartRate = freezed,
    Object? maxHeartRate = freezed,
    Object? calories = freezed,
    Object? polyline = freezed,
    Object? mapSnapshotUrl = freezed,
    Object? splits = null,
    Object? xpEarned = null,
    Object? xpBreakdown = freezed,
    Object? isDuplicate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$WorkoutImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      integrationId: freezed == integrationId
          ? _value.integrationId
          : integrationId // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as IntegrationProvider?,
      providerActivityId: freezed == providerActivityId
          ? _value.providerActivityId
          : providerActivityId // ignore: cast_nullable_to_non_nullable
              as String?,
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as WorkoutSportType,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      avgPaceSecondsPerKm: freezed == avgPaceSecondsPerKm
          ? _value.avgPaceSecondsPerKm
          : avgPaceSecondsPerKm // ignore: cast_nullable_to_non_nullable
              as double?,
      avgSpeedKmh: freezed == avgSpeedKmh
          ? _value.avgSpeedKmh
          : avgSpeedKmh // ignore: cast_nullable_to_non_nullable
              as double?,
      maxSpeedKmh: freezed == maxSpeedKmh
          ? _value.maxSpeedKmh
          : maxSpeedKmh // ignore: cast_nullable_to_non_nullable
              as double?,
      elevationGainMeters: null == elevationGainMeters
          ? _value.elevationGainMeters
          : elevationGainMeters // ignore: cast_nullable_to_non_nullable
              as double,
      elevationLossMeters: null == elevationLossMeters
          ? _value.elevationLossMeters
          : elevationLossMeters // ignore: cast_nullable_to_non_nullable
              as double,
      avgHeartRate: freezed == avgHeartRate
          ? _value.avgHeartRate
          : avgHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      maxHeartRate: freezed == maxHeartRate
          ? _value.maxHeartRate
          : maxHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      polyline: freezed == polyline
          ? _value.polyline
          : polyline // ignore: cast_nullable_to_non_nullable
              as String?,
      mapSnapshotUrl: freezed == mapSnapshotUrl
          ? _value.mapSnapshotUrl
          : mapSnapshotUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      splits: null == splits
          ? _value._splits
          : splits // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSplit>,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      xpBreakdown: freezed == xpBreakdown
          ? _value.xpBreakdown
          : xpBreakdown // ignore: cast_nullable_to_non_nullable
              as XpBreakdownData?,
      isDuplicate: null == isDuplicate
          ? _value.isDuplicate
          : isDuplicate // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$WorkoutImpl implements _Workout {
  const _$WorkoutImpl(
      {required this.id,
      required this.userId,
      this.integrationId,
      this.provider,
      this.providerActivityId,
      required this.sportType,
      this.name,
      this.description,
      required this.startedAt,
      this.endedAt,
      required this.durationSeconds,
      this.distanceMeters = 0,
      this.avgPaceSecondsPerKm,
      this.avgSpeedKmh,
      this.maxSpeedKmh,
      this.elevationGainMeters = 0,
      this.elevationLossMeters = 0,
      this.avgHeartRate,
      this.maxHeartRate,
      this.calories,
      this.polyline,
      this.mapSnapshotUrl,
      final List<WorkoutSplit> splits = const [],
      this.xpEarned = 0,
      this.xpBreakdown,
      this.isDuplicate = false,
      required this.createdAt,
      required this.updatedAt})
      : _splits = splits;

  factory _$WorkoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? integrationId;
  @override
  final IntegrationProvider? provider;
  @override
  final String? providerActivityId;
  @override
  final WorkoutSportType sportType;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int durationSeconds;
  @override
  @JsonKey()
  final double distanceMeters;
  @override
  final double? avgPaceSecondsPerKm;
  @override
  final double? avgSpeedKmh;
  @override
  final double? maxSpeedKmh;
  @override
  @JsonKey()
  final double elevationGainMeters;
  @override
  @JsonKey()
  final double elevationLossMeters;
  @override
  final int? avgHeartRate;
  @override
  final int? maxHeartRate;
  @override
  final int? calories;
  @override
  final String? polyline;
  @override
  final String? mapSnapshotUrl;
  final List<WorkoutSplit> _splits;
  @override
  @JsonKey()
  List<WorkoutSplit> get splits {
    if (_splits is EqualUnmodifiableListView) return _splits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_splits);
  }

  @override
  @JsonKey()
  final int xpEarned;
  @override
  final XpBreakdownData? xpBreakdown;
  @override
  @JsonKey()
  final bool isDuplicate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Workout(id: $id, userId: $userId, integrationId: $integrationId, provider: $provider, providerActivityId: $providerActivityId, sportType: $sportType, name: $name, description: $description, startedAt: $startedAt, endedAt: $endedAt, durationSeconds: $durationSeconds, distanceMeters: $distanceMeters, avgPaceSecondsPerKm: $avgPaceSecondsPerKm, avgSpeedKmh: $avgSpeedKmh, maxSpeedKmh: $maxSpeedKmh, elevationGainMeters: $elevationGainMeters, elevationLossMeters: $elevationLossMeters, avgHeartRate: $avgHeartRate, maxHeartRate: $maxHeartRate, calories: $calories, polyline: $polyline, mapSnapshotUrl: $mapSnapshotUrl, splits: $splits, xpEarned: $xpEarned, xpBreakdown: $xpBreakdown, isDuplicate: $isDuplicate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.integrationId, integrationId) ||
                other.integrationId == integrationId) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.providerActivityId, providerActivityId) ||
                other.providerActivityId == providerActivityId) &&
            (identical(other.sportType, sportType) ||
                other.sportType == sportType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.avgPaceSecondsPerKm, avgPaceSecondsPerKm) ||
                other.avgPaceSecondsPerKm == avgPaceSecondsPerKm) &&
            (identical(other.avgSpeedKmh, avgSpeedKmh) ||
                other.avgSpeedKmh == avgSpeedKmh) &&
            (identical(other.maxSpeedKmh, maxSpeedKmh) ||
                other.maxSpeedKmh == maxSpeedKmh) &&
            (identical(other.elevationGainMeters, elevationGainMeters) ||
                other.elevationGainMeters == elevationGainMeters) &&
            (identical(other.elevationLossMeters, elevationLossMeters) ||
                other.elevationLossMeters == elevationLossMeters) &&
            (identical(other.avgHeartRate, avgHeartRate) ||
                other.avgHeartRate == avgHeartRate) &&
            (identical(other.maxHeartRate, maxHeartRate) ||
                other.maxHeartRate == maxHeartRate) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.polyline, polyline) ||
                other.polyline == polyline) &&
            (identical(other.mapSnapshotUrl, mapSnapshotUrl) ||
                other.mapSnapshotUrl == mapSnapshotUrl) &&
            const DeepCollectionEquality().equals(other._splits, _splits) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.xpBreakdown, xpBreakdown) ||
                other.xpBreakdown == xpBreakdown) &&
            (identical(other.isDuplicate, isDuplicate) ||
                other.isDuplicate == isDuplicate) &&
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
        userId,
        integrationId,
        provider,
        providerActivityId,
        sportType,
        name,
        description,
        startedAt,
        endedAt,
        durationSeconds,
        distanceMeters,
        avgPaceSecondsPerKm,
        avgSpeedKmh,
        maxSpeedKmh,
        elevationGainMeters,
        elevationLossMeters,
        avgHeartRate,
        maxHeartRate,
        calories,
        polyline,
        mapSnapshotUrl,
        const DeepCollectionEquality().hash(_splits),
        xpEarned,
        xpBreakdown,
        isDuplicate,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutImplCopyWith<_$WorkoutImpl> get copyWith =>
      __$$WorkoutImplCopyWithImpl<_$WorkoutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutImplToJson(
      this,
    );
  }
}

abstract class _Workout implements Workout {
  const factory _Workout(
      {required final String id,
      required final String userId,
      final String? integrationId,
      final IntegrationProvider? provider,
      final String? providerActivityId,
      required final WorkoutSportType sportType,
      final String? name,
      final String? description,
      required final DateTime startedAt,
      final DateTime? endedAt,
      required final int durationSeconds,
      final double distanceMeters,
      final double? avgPaceSecondsPerKm,
      final double? avgSpeedKmh,
      final double? maxSpeedKmh,
      final double elevationGainMeters,
      final double elevationLossMeters,
      final int? avgHeartRate,
      final int? maxHeartRate,
      final int? calories,
      final String? polyline,
      final String? mapSnapshotUrl,
      final List<WorkoutSplit> splits,
      final int xpEarned,
      final XpBreakdownData? xpBreakdown,
      final bool isDuplicate,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$WorkoutImpl;

  factory _Workout.fromJson(Map<String, dynamic> json) = _$WorkoutImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get integrationId;
  @override
  IntegrationProvider? get provider;
  @override
  String? get providerActivityId;
  @override
  WorkoutSportType get sportType;
  @override
  String? get name;
  @override
  String? get description;
  @override
  DateTime get startedAt;
  @override
  DateTime? get endedAt;
  @override
  int get durationSeconds;
  @override
  double get distanceMeters;
  @override
  double? get avgPaceSecondsPerKm;
  @override
  double? get avgSpeedKmh;
  @override
  double? get maxSpeedKmh;
  @override
  double get elevationGainMeters;
  @override
  double get elevationLossMeters;
  @override
  int? get avgHeartRate;
  @override
  int? get maxHeartRate;
  @override
  int? get calories;
  @override
  String? get polyline;
  @override
  String? get mapSnapshotUrl;
  @override
  List<WorkoutSplit> get splits;
  @override
  int get xpEarned;
  @override
  XpBreakdownData? get xpBreakdown;
  @override
  bool get isDuplicate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutImplCopyWith<_$WorkoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
