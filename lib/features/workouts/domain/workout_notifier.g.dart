// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workoutListHash() => r'92d55f3a83f800fd5112c0182a0c8b226a4efb80';

/// See also [workoutList].
@ProviderFor(workoutList)
final workoutListProvider = AutoDisposeFutureProvider<List<Workout>>.internal(
  workoutList,
  name: r'workoutListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$workoutListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkoutListRef = AutoDisposeFutureProviderRef<List<Workout>>;
String _$workoutDetailHash() => r'd07eda01ee4d9981decffab43d695a6a7707cb10';

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

/// See also [workoutDetail].
@ProviderFor(workoutDetail)
const workoutDetailProvider = WorkoutDetailFamily();

/// See also [workoutDetail].
class WorkoutDetailFamily extends Family<AsyncValue<Workout?>> {
  /// See also [workoutDetail].
  const WorkoutDetailFamily();

  /// See also [workoutDetail].
  WorkoutDetailProvider call(
    String workoutId,
  ) {
    return WorkoutDetailProvider(
      workoutId,
    );
  }

  @override
  WorkoutDetailProvider getProviderOverride(
    covariant WorkoutDetailProvider provider,
  ) {
    return call(
      provider.workoutId,
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
  String? get name => r'workoutDetailProvider';
}

/// See also [workoutDetail].
class WorkoutDetailProvider extends AutoDisposeFutureProvider<Workout?> {
  /// See also [workoutDetail].
  WorkoutDetailProvider(
    String workoutId,
  ) : this._internal(
          (ref) => workoutDetail(
            ref as WorkoutDetailRef,
            workoutId,
          ),
          from: workoutDetailProvider,
          name: r'workoutDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$workoutDetailHash,
          dependencies: WorkoutDetailFamily._dependencies,
          allTransitiveDependencies:
              WorkoutDetailFamily._allTransitiveDependencies,
          workoutId: workoutId,
        );

  WorkoutDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workoutId,
  }) : super.internal();

  final String workoutId;

  @override
  Override overrideWith(
    FutureOr<Workout?> Function(WorkoutDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkoutDetailProvider._internal(
        (ref) => create(ref as WorkoutDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workoutId: workoutId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Workout?> createElement() {
    return _WorkoutDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutDetailProvider && other.workoutId == workoutId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workoutId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkoutDetailRef on AutoDisposeFutureProviderRef<Workout?> {
  /// The parameter `workoutId` of this provider.
  String get workoutId;
}

class _WorkoutDetailProviderElement
    extends AutoDisposeFutureProviderElement<Workout?> with WorkoutDetailRef {
  _WorkoutDetailProviderElement(super.provider);

  @override
  String get workoutId => (origin as WorkoutDetailProvider).workoutId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
