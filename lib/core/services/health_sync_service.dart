import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

part 'health_sync_service.g.dart';

/// Result of a health sync operation.
class HealthSyncResult {
  const HealthSyncResult({
    required this.imported,
    required this.duplicates,
    required this.total,
  });

  final int imported;
  final int duplicates;
  final int total;
}

@riverpod
HealthSyncService healthSyncService(Ref ref) => HealthSyncService();

/// Reads workouts from Apple HealthKit (iOS) or Google Fit (Android)
/// and POSTs them to the `health-sync` Edge Function for server-side processing.
class HealthSyncService {
  final _health = Health();
  final _dio = Dio();

  /// Health data types Fynix reads.
  static const List<HealthDataType> _types = [
    HealthDataType.WORKOUT,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.DISTANCE_CYCLING,
    HealthDataType.DISTANCE_SWIMMING,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
  ];

  /// Requests HealthKit / Google Fit permissions.
  /// Returns true if all permissions are granted.
  Future<bool> requestPermissions() async {
    try {
      final permissions = _types.map((_) => HealthDataAccess.READ).toList();
      final granted = await _health.requestAuthorization(_types, permissions: permissions);
      return granted;
    } catch (e) {
      debugPrint('Health permission error: $e');
      return false;
    }
  }

  /// Fetches workouts from the device health store and syncs them to the server.
  ///
  /// [lastSyncDate] — only fetch workouts after this date (incremental sync).
  /// Pass null to fetch the last 90 days (initial sync).
  Future<HealthSyncResult> sync({DateTime? lastSyncDate}) async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) throw Exception('User not authenticated');

    final startDate = lastSyncDate ?? DateTime.now().subtract(const Duration(days: 90));
    final endDate = DateTime.now();

    final provider = defaultTargetPlatform == TargetPlatform.iOS
        ? 'apple_health'
        : 'google_fit';

    List<HealthDataPoint> healthData = [];
    try {
      healthData = await _health.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.WORKOUT],
      );
    } catch (e) {
      debugPrint('Health data fetch error: $e');
      return const HealthSyncResult(imported: 0, duplicates: 0, total: 0);
    }

    if (healthData.isEmpty) {
      return const HealthSyncResult(imported: 0, duplicates: 0, total: 0);
    }

    // Map HealthDataPoints to the server payload format
    final workouts = healthData
        .where((p) => p.type == HealthDataType.WORKOUT)
        .map((p) => _mapHealthPoint(p))
        .where((w) => w != null)
        .cast<Map<String, dynamic>>()
        .toList();

    if (workouts.isEmpty) {
      return const HealthSyncResult(imported: 0, duplicates: 0, total: 0);
    }

    try {
      final response = await _dio.post(
        '${dotenv.env['SUPABASE_URL']}/functions/v1/health-sync',
        data: {'provider': provider, 'workouts': workouts},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${session.accessToken}',
            'apikey': dotenv.env['SUPABASE_ANON_KEY'],
            'Content-Type': 'application/json',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;
      return HealthSyncResult(
        imported: data['imported'] as int? ?? 0,
        duplicates: data['duplicates'] as int? ?? 0,
        total: data['total'] as int? ?? 0,
      );
    } on DioException catch (e) {
      debugPrint('Health sync error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Maps Apple HealthKit / Google Fit workout type strings to Fynix sport_type enum values.
  static const Map<String, String> _hkTypeMap = {
    'HKWorkoutActivityTypeRunning': 'running',
    'HKWorkoutActivityTypeCycling': 'cycling',
    'HKWorkoutActivityTypeSwimming': 'swimming',
    'HKWorkoutActivityTypeWalking': 'walking',
    'HKWorkoutActivityTypeHiking': 'hiking',
    'HKWorkoutActivityTypeTraditionalStrengthTraining': 'strength',
    'HKWorkoutActivityTypeFunctionalStrengthTraining': 'strength',
    'HKWorkoutActivityTypeYoga': 'yoga',
    'HKWorkoutActivityTypeCrossTraining': 'crossfit',
    'HKWorkoutActivityTypeTriathlon': 'triathlon',
  };

  Map<String, dynamic>? _mapHealthPoint(HealthDataPoint point) {
    try {
      final workoutData = point.value as WorkoutHealthValue?;
      if (workoutData == null) return null;

      final sportType = _hkTypeMap[workoutData.workoutActivityType.name] ?? 'other';
      final startedAt = point.dateFrom.toIso8601String();
      final endedAt = point.dateTo.toIso8601String();
      final durationSeconds = point.dateTo.difference(point.dateFrom).inSeconds;

      if (durationSeconds <= 0) return null;

      return {
        'provider_activity_id': '${provider}_${point.sourceId}_${point.dateFrom.millisecondsSinceEpoch}',
        'sport_type': sportType,
        'started_at': startedAt,
        'ended_at': endedAt,
        'duration_seconds': durationSeconds,
        'distance_meters': workoutData.totalDistance,
        'calories': workoutData.totalEnergyBurned?.toInt(),
      };
    } catch (e) {
      debugPrint('Failed to map health point: $e');
      return null;
    }
  }

  String get provider => defaultTargetPlatform == TargetPlatform.iOS
      ? 'apple_health'
      : 'google_fit';
}
