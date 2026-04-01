// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trainingPlansHash() => r'62846a03c7bee609f711351a08bc5eae11f7d0bb';

/// See also [trainingPlans].
@ProviderFor(trainingPlans)
final trainingPlansProvider =
    AutoDisposeFutureProvider<List<TrainingPlan>>.internal(
  trainingPlans,
  name: r'trainingPlansProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$trainingPlansHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TrainingPlansRef = AutoDisposeFutureProviderRef<List<TrainingPlan>>;
String _$trainingPlanDetailHash() =>
    r'910101b8db450cb132ece5db13edd1266e45e4a4';

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

/// See also [trainingPlanDetail].
@ProviderFor(trainingPlanDetail)
const trainingPlanDetailProvider = TrainingPlanDetailFamily();

/// See also [trainingPlanDetail].
class TrainingPlanDetailFamily extends Family<AsyncValue<TrainingPlan?>> {
  /// See also [trainingPlanDetail].
  const TrainingPlanDetailFamily();

  /// See also [trainingPlanDetail].
  TrainingPlanDetailProvider call(
    String planId,
  ) {
    return TrainingPlanDetailProvider(
      planId,
    );
  }

  @override
  TrainingPlanDetailProvider getProviderOverride(
    covariant TrainingPlanDetailProvider provider,
  ) {
    return call(
      provider.planId,
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
  String? get name => r'trainingPlanDetailProvider';
}

/// See also [trainingPlanDetail].
class TrainingPlanDetailProvider
    extends AutoDisposeFutureProvider<TrainingPlan?> {
  /// See also [trainingPlanDetail].
  TrainingPlanDetailProvider(
    String planId,
  ) : this._internal(
          (ref) => trainingPlanDetail(
            ref as TrainingPlanDetailRef,
            planId,
          ),
          from: trainingPlanDetailProvider,
          name: r'trainingPlanDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trainingPlanDetailHash,
          dependencies: TrainingPlanDetailFamily._dependencies,
          allTransitiveDependencies:
              TrainingPlanDetailFamily._allTransitiveDependencies,
          planId: planId,
        );

  TrainingPlanDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.planId,
  }) : super.internal();

  final String planId;

  @override
  Override overrideWith(
    FutureOr<TrainingPlan?> Function(TrainingPlanDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TrainingPlanDetailProvider._internal(
        (ref) => create(ref as TrainingPlanDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        planId: planId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TrainingPlan?> createElement() {
    return _TrainingPlanDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrainingPlanDetailProvider && other.planId == planId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, planId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TrainingPlanDetailRef on AutoDisposeFutureProviderRef<TrainingPlan?> {
  /// The parameter `planId` of this provider.
  String get planId;
}

class _TrainingPlanDetailProviderElement
    extends AutoDisposeFutureProviderElement<TrainingPlan?>
    with TrainingPlanDetailRef {
  _TrainingPlanDetailProviderElement(super.provider);

  @override
  String get planId => (origin as TrainingPlanDetailProvider).planId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
