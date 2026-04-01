import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fynix/core/models/workout.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/workouts/data/workout_repository.dart';

part 'workout_notifier.g.dart';

@riverpod
Future<List<Workout>> workoutList(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(workoutRepositoryProvider).fetchUserWorkouts(userId: user.id);
}

@riverpod
Future<Workout?> workoutDetail(Ref ref, String workoutId) async {
  return ref.read(workoutRepositoryProvider).fetchWorkout(workoutId);
}
