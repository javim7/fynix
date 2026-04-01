import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/models/training_plan.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/training/data/training_repository.dart';

part 'training_notifier.g.dart';

@riverpod
Future<List<TrainingPlan>> trainingPlans(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  return ref.read(trainingRepositoryProvider).fetchPlans(userId: user?.id);
}

@riverpod
Future<TrainingPlan?> trainingPlanDetail(Ref ref, String planId) async {
  return ref.read(trainingRepositoryProvider).fetchPlanDetail(planId);
}
