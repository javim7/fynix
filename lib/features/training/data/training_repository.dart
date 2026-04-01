import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fynix/core/models/training_plan.dart';

part 'training_repository.g.dart';

@riverpod
TrainingRepository trainingRepository(Ref ref) => TrainingRepository();

class TrainingRepository {
  final _client = Supabase.instance.client;

  Future<List<TrainingPlan>> fetchPlans({String? userId}) async {
    final data = await _client
        .from('training_plans')
        .select()
        .order('target_distance')
        .order('level');

    final plans = (data as List)
        .map((e) => TrainingPlan.fromJson(e as Map<String, dynamic>))
        .toList();

    if (userId == null) return plans;

    final activePlans = await _client
        .from('user_active_plans')
        .select('plan_id, current_week, current_day, started_at, is_active')
        .eq('user_id', userId)
        .eq('is_active', true);

    final activeMap = {
      for (final p in (activePlans as List))
        (p as Map<String, dynamic>)['plan_id'] as String: p,
    };

    return plans.map((p) {
      final active = activeMap[p.id];
      if (active == null) return p;
      return p.copyWith(
        isActive: true,
        currentWeek: active['current_week'] as int,
        currentDay: active['current_day'] as int,
        startedAt: DateTime.parse(active['started_at'] as String),
      );
    }).toList();
  }

  Future<TrainingPlan?> fetchPlanDetail(String planId) async {
    final planData = await _client
        .from('training_plans')
        .select()
        .eq('id', planId)
        .single();

    final weeksData = await _client
        .from('training_plan_weeks')
        .select('*, workouts:training_plan_workouts(*)')
        .eq('plan_id', planId)
        .order('week_number');

    final weeks = (weeksData as List).map((w) {
      final weekMap = w as Map<String, dynamic>;
      final workouts = (weekMap['workouts'] as List)
          .map((wo) =>
              TrainingPlanWorkout.fromJson(wo as Map<String, dynamic>))
          .toList();
      return TrainingPlanWeek.fromJson({...weekMap, 'workouts': workouts.map((w) => w.toJson()).toList()});
    }).toList();

    final plan = TrainingPlan.fromJson(planData as Map<String, dynamic>);
    return plan.copyWith(weeks: weeks);
  }

  Future<void> startPlan({
    required String userId,
    required String planId,
  }) async {
    await _client.from('user_active_plans').upsert(
      {
        'user_id': userId,
        'plan_id': planId,
        'started_at': DateTime.now().toIso8601String(),
        'current_week': 1,
        'current_day': 1,
        'is_active': true,
      },
      onConflict: 'user_id,plan_id',
    );
  }
}
