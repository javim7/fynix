import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/utils/distance_formatter.dart';
import 'package:fynix/core/utils/pace_formatter.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/sport_icon.dart';
import 'package:fynix/core/widgets/xp_bar.dart';
import 'package:fynix/features/workouts/domain/workout_notifier.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  const WorkoutDetailScreen({super.key, required this.workoutId});

  final String workoutId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutAsync = ref.watch(workoutDetailProvider(workoutId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del entrenamiento')),
      body: workoutAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (workout) {
          if (workout == null) return const Center(child: Text('No encontrado'));
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    SportIcon(sport: workout.sportType, size: 32),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        workout.name ?? SportIcon.labelFor(workout.sportType),
                        style: AppTypography.h2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                // Stats grid
                Row(
                  children: [
                    Expanded(child: _StatTile(label: 'Distancia', value: DistanceFormatter.formatKm(workout.distanceMeters))),
                    Expanded(child: _StatTile(label: 'Duración', value: PaceFormatter.formatDuration(workout.durationSeconds))),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(child: _StatTile(label: 'Ritmo prom.', value: workout.avgPaceSecondsPerKm != null ? PaceFormatter.format(workout.avgPaceSecondsPerKm!) : '--')),
                    Expanded(child: _StatTile(label: 'Calorías', value: workout.calories != null ? '${workout.calories} kcal' : '--')),
                  ],
                ),
                if (workout.avgHeartRate != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(child: _StatTile(label: 'FC prom.', value: '${workout.avgHeartRate} bpm')),
                      Expanded(child: _StatTile(label: 'FC máx.', value: '${workout.maxHeartRate ?? '--'} bpm')),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                // XP earned
                FynixCard(
                  border: Border.all(color: AppColors.gold.withAlpha(80)),
                  child: Column(
                    children: [
                      Text('XP ganado', style: AppTypography.labelMedium),
                      Text('+${workout.xpEarned} XP', style: AppTypography.statDisplay),
                      if (workout.xpBreakdown != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text('Base: ${workout.xpBreakdown!.baseXp} + Racha: ${workout.xpBreakdown!.streakBonus}', style: AppTypography.bodySmall),
                      ],
                    ],
                  ),
                ),
                // Map placeholder
                if (workout.polyline != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.darkEmber,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    ),
                    child: const Center(
                      child: Text('Mapa de ruta', style: AppTypography.bodySmall),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Text(value, style: AppTypography.statLarge),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}
