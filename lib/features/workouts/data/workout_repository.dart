import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fynix/core/models/workout.dart';

part 'workout_repository.g.dart';

@riverpod
WorkoutRepository workoutRepository(Ref ref) => WorkoutRepository();

class WorkoutRepository {
  final _client = Supabase.instance.client;

  Future<List<Workout>> fetchUserWorkouts({
    required String userId,
    int limit = 20,
    DateTime? before,
  }) async {
    var baseQuery = _client
        .from('workouts')
        .select()
        .eq('user_id', userId)
        .eq('is_duplicate', false);

    if (before != null) {
      baseQuery = baseQuery.lt('started_at', before.toIso8601String());
    }

    final data = await baseQuery
        .order('started_at', ascending: false)
        .limit(limit);
    return (data as List).map((e) => Workout.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Workout?> fetchWorkout(String workoutId) async {
    final data = await _client
        .from('workouts')
        .select()
        .eq('id', workoutId)
        .single();
    return Workout.fromJson(data);
  }

  Future<void> updateWorkoutCaption({
    required String workoutId,
    required String caption,
  }) async {
    await _client
        .from('workouts')
        .update({'description': caption})
        .eq('id', workoutId);
  }
}
