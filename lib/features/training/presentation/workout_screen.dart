import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/utils/distance_formatter.dart';
import 'package:fynix/core/utils/pace_formatter.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/training/domain/training_notifier.dart';

/// Displays a single scheduled training workout with instructions.
class TrainingWorkoutScreen extends ConsumerWidget {
  const TrainingWorkoutScreen({
    super.key,
    required this.planId,
    required this.workoutId,
  });

  final String planId;
  final String workoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(trainingPlanDetailProvider(planId));

    return Scaffold(
      appBar: AppBar(title: const Text('Entrenamiento del día')),
      body: planAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plan) {
          if (plan == null) return const Center(child: Text('No encontrado'));

          // Find the specific workout across all weeks
          final workouts =
              plan.weeks.expand((w) => w.workouts).toList();
          final wo = workouts.where((w) => w.id == workoutId).firstOrNull;

          if (wo == null) {
            return const Center(child: Text('Entrenamiento no encontrado'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wo.title, style: AppTypography.h2),
                const SizedBox(height: AppSpacing.sm),
                if (wo.description != null)
                  Text(wo.description!, style: AppTypography.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                // Targets
                if (wo.targetDistanceMeters != null ||
                    wo.targetDurationSeconds != null)
                  FynixCard(
                    child: Row(
                      children: [
                        if (wo.targetDistanceMeters != null)
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  DistanceFormatter.formatKm(
                                      wo.targetDistanceMeters!.toDouble()),
                                  style: AppTypography.statLarge,
                                ),
                                Text('Objetivo', style: AppTypography.labelSmall),
                              ],
                            ),
                          ),
                        if (wo.targetDurationSeconds != null)
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  PaceFormatter.formatDurationHuman(
                                      wo.targetDurationSeconds!),
                                  style: AppTypography.statLarge,
                                ),
                                Text('Duración', style: AppTypography.labelSmall),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                if (wo.instructions != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text('Instrucciones', style: AppTypography.h4),
                  const SizedBox(height: AppSpacing.sm),
                  Text(wo.instructions!, style: AppTypography.bodyMedium),
                ],
                const SizedBox(height: AppSpacing.xl),
                FynixButton(
                  label: 'Marcar como completado',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.check_circle_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
