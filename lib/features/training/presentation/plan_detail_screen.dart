import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/training/data/training_repository.dart';
import 'package:fynix/features/training/domain/training_notifier.dart';

class PlanDetailScreen extends ConsumerStatefulWidget {
  const PlanDetailScreen({super.key, required this.planId});

  final String planId;

  @override
  ConsumerState<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends ConsumerState<PlanDetailScreen> {
  bool _isStarting = false;

  Future<void> _startPlan() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;
    setState(() => _isStarting = true);
    try {
      await ref.read(trainingRepositoryProvider).startPlan(
            userId: user.id,
            planId: widget.planId,
          );
      ref.invalidate(trainingPlanDetailProvider(widget.planId));
    } finally {
      if (mounted) setState(() => _isStarting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(trainingPlanDetailProvider(widget.planId));

    return Scaffold(
      appBar: AppBar(title: const Text('Plan de entrenamiento')),
      body: planAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plan) {
          if (plan == null) return const Center(child: Text('No encontrado'));
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    Text(plan.title, style: AppTypography.h2),
                    const SizedBox(height: AppSpacing.xs),
                    if (plan.description != null)
                      Text(plan.description!, style: AppTypography.bodyMedium),
                    const SizedBox(height: AppSpacing.lg),
                    Text('Programa (${plan.durationWeeks} semanas)',
                        style: AppTypography.h4),
                    const SizedBox(height: AppSpacing.sm),
                    ...plan.weeks.map((week) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: FynixCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Semana ${week.weekNumber}: ${week.focus}',
                                    style: AppTypography.h4),
                                if (week.description != null)
                                  Text(week.description!,
                                      style: AppTypography.bodySmall),
                                const SizedBox(height: AppSpacing.sm),
                                ...week.workouts.map((wo) => Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: AppSpacing.xs),
                                      child: Row(
                                        children: [
                                          Text('Día ${wo.dayNumber}:',
                                              style: AppTypography.labelMedium),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(wo.title,
                                                style:
                                                    AppTypography.bodySmall),
                                          ),
                                          if (plan.isActive &&
                                              plan.currentWeek ==
                                                  week.weekNumber &&
                                              plan.currentDay == wo.dayNumber)
                                            TextButton(
                                              onPressed: () => context.push(
                                                  '/training/${widget.planId}/workout/${wo.id}'),
                                              child: const Text('Ver'),
                                            ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: plan.isActive
                    ? FynixButton(
                        label: 'Continuar — Semana ${plan.currentWeek}',
                        onPressed: () => context.push(
                            '/training/${widget.planId}/workout/${plan.currentWeek}'),
                        icon: Icons.play_arrow_rounded,
                      )
                    : FynixButton(
                        label: 'Iniciar plan',
                        onPressed: _startPlan,
                        isLoading: _isStarting,
                        icon: Icons.flag_rounded,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
