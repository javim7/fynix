import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/training_plan.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/premium_gate.dart';
import 'package:fynix/features/training/domain/training_notifier.dart';

class TrainingPlansScreen extends ConsumerWidget {
  const TrainingPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planes de entrenamiento')),
      body: PremiumGate(
        featureName: 'Planes de entrenamiento',
        child: _PlansList(),
      ),
    );
  }
}

class _PlansList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(trainingPlansProvider);

    return plansAsync.when(
      loading: () =>
          const Center(child: CircularProgressIndicator(color: AppColors.gold)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plans) {
        final distances = ['5k', '10k', '21k'];

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: distances.map((dist) {
            final distPlans = plans.where((p) => p.targetDistance == dist).toList();
            if (distPlans.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_distanceLabel(dist), style: AppTypography.h3),
                const SizedBox(height: AppSpacing.sm),
                ...distPlans.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _PlanCard(
                        plan: p,
                        onTap: () => context.push('/training/${p.id}'),
                      ),
                    )),
                const SizedBox(height: AppSpacing.md),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  String _distanceLabel(String dist) {
    switch (dist) {
      case '5k':
        return '5K';
      case '10k':
        return '10K';
      case '21k':
        return 'Media Maratón (21K)';
      default:
        return dist.toUpperCase();
    }
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.onTap});

  final TrainingPlan plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      onTap: onTap,
      border: plan.isActive
          ? Border.all(color: AppColors.gold, width: 1.5)
          : null,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.title, style: AppTypography.h4),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _Badge(_levelLabel(plan.level)),
                    const SizedBox(width: AppSpacing.xs),
                    _Badge('${plan.durationWeeks} semanas'),
                  ],
                ),
                if (plan.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    plan.description!,
                    style: AppTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (plan.isActive)
            Column(
              children: [
                const Icon(Icons.play_circle_rounded,
                    color: AppColors.gold, size: 28),
                Text('Semana ${plan.currentWeek}',
                    style: AppTypography.labelSmall),
              ],
            )
          else
            const Icon(Icons.chevron_right_rounded, color: AppColors.midGray),
        ],
      ),
    );
  }

  String _levelLabel(String level) {
    switch (level) {
      case 'beginner':
        return 'Principiante';
      case 'intermediate':
        return 'Intermedio';
      case 'advanced':
        return 'Avanzado';
      default:
        return level;
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(label, style: AppTypography.labelSmall),
    );
  }
}
