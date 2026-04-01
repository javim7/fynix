// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strava_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stravaServiceHash() => r'b37abefbdcf60fd09e6bf894471ad8051025f86d';

/// Handles Strava OAuth2 flow and token management.
///
/// OAuth flow:
/// 1. [launchAuthUrl] — opens Strava authorization page
/// 2. Deep link `fynix://strava/callback?code=...` is caught by the app
/// 3. [exchangeCodeForTokens] — exchanges code for access + refresh tokens via Edge Function
///
/// Copied from [stravaService].
@ProviderFor(stravaService)
final stravaServiceProvider = AutoDisposeProvider<StravaService>.internal(
  stravaService,
  name: r'stravaServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stravaServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StravaServiceRef = AutoDisposeProviderRef<StravaService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
