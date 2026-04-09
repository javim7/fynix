import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/training_plan.dart';
import 'package:fynix/core/models/workout.dart';
import 'package:fynix/core/utils/date_helpers.dart';
import 'package:fynix/core/utils/distance_formatter.dart';
import 'package:fynix/core/utils/pace_formatter.dart';
import 'package:fynix/core/widgets/activity_route_preview_strip.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/sport_icon.dart';
import 'package:fynix/features/training/domain/training_notifier.dart';
import 'package:fynix/features/workouts/domain/workout_notifier.dart';

enum _TimeRange { weekly, monthly, yearly }

class WorkoutHistoryScreen extends ConsumerStatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  ConsumerState<WorkoutHistoryScreen> createState() =>
      _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends ConsumerState<WorkoutHistoryScreen> {
  _TimeRange _range = _TimeRange.weekly;
  WorkoutSportType? _sportFilter;

  @override
  Widget build(BuildContext context) {
    final workoutsAsync = ref.watch(workoutListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progreso'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () => context.push(Routes.xpHistory),
            tooltip: 'Historial XP',
          ),
        ],
      ),
      body: workoutsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (workouts) => _ProgressBody(
          workouts: workouts,
          range: _range,
          sportFilter: _sportFilter,
          onRangeChanged: (r) => setState(() => _range = r),
          onSportFilterChanged: (s) => setState(() => _sportFilter = s),
        ),
      ),
    );
  }
}

class _ProgressBody extends ConsumerWidget {
  const _ProgressBody({
    required this.workouts,
    required this.range,
    required this.sportFilter,
    required this.onRangeChanged,
    required this.onSportFilterChanged,
  });

  final List<Workout> workouts;
  final _TimeRange range;
  final WorkoutSportType? sportFilter;
  final ValueChanged<_TimeRange> onRangeChanged;
  final ValueChanged<WorkoutSportType?> onSportFilterChanged;

  List<Workout> get _filtered {
    final now = DateTime.now();
    final DateTime cutoff;
    switch (range) {
      case _TimeRange.weekly:
        cutoff = now.subtract(const Duration(days: 7));
      case _TimeRange.monthly:
        cutoff = now.subtract(const Duration(days: 30));
      case _TimeRange.yearly:
        cutoff = DateTime(now.year);
    }
    return workouts.where((w) {
      if (w.startedAt.isBefore(cutoff)) return false;
      if (sportFilter != null && w.sportType != sportFilter) return false;
      return true;
    }).toList();
  }

  String get _chartTitle {
    switch (range) {
      case _TimeRange.weekly:
        return 'Distancia esta semana';
      case _TimeRange.monthly:
        return 'Distancia este mes';
      case _TimeRange.yearly:
        return 'Distancia este año';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(trainingPlansProvider);
    final filtered = _filtered;

    final totalKm = filtered.fold<double>(
      0,
      (sum, w) => sum + w.distanceMeters / 1000,
    );
    final totalXp = filtered.fold<int>(0, (sum, w) => sum + w.xpEarned);
    final totalWorkouts = filtered.length;

    final activePlanMatches = plansAsync.whenOrNull(
      data: (plans) => plans.where((p) => p.isActive).toList(),
    );
    final activePlan =
        (activePlanMatches != null && activePlanMatches.isNotEmpty)
            ? activePlanMatches.first
            : null;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            0,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // ── Training plan section ─────────────────────────────────
              _TrainingPlanSection(activePlan: activePlan),
              const SizedBox(height: AppSpacing.md),

              // ── Time range toggle ─────────────────────────────────────
              _TimeToggle(
                selected: range,
                onChanged: onRangeChanged,
              ),
              const SizedBox(height: AppSpacing.sm),

              // ── Sport filter pills ────────────────────────────────────
              _SportFilterRow(
                selected: sportFilter,
                onChanged: onSportFilterChanged,
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Summary stats ─────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: totalKm.toStringAsFixed(1),
                      unit: 'km',
                      label: 'Distancia',
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _StatCard(
                      value: '$totalWorkouts',
                      unit: '',
                      label: 'Entrenos',
                      color: AppColors.flameCoral,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _StatCard(
                      value: '$totalXp',
                      unit: 'XP',
                      label: 'Ganados',
                      color: AppColors.xpGreen,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 300.ms),
              const SizedBox(height: AppSpacing.md),

              // ── Chart ─────────────────────────────────────────────────
              FynixCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _chartTitle,
                      style: AppTypography.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 140,
                      child: _DistanceChart(
                        workouts: filtered,
                        range: range,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 350.ms),
              const SizedBox(height: AppSpacing.md),

              // ── Activity list header ──────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Actividades', style: AppTypography.h4),
                  Text(
                    '${filtered.length} actividades',
                    style: AppTypography.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
            ]),
          ),
        ),

        // ── Activity list ─────────────────────────────────────────────
        if (filtered.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyState(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.xl,
            ),
            sliver: SliverList.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) => _WorkoutCard(
                workout: filtered[i],
                onTap: () => context.push('/workouts/${filtered[i].id}'),
              )
                  .animate(delay: (50 * i).ms)
                  .fadeIn(duration: 250.ms)
                  .slideY(begin: 0.04, end: 0, duration: 250.ms),
            ),
          ),
      ],
    );
  }
}

// ─── Training plan section (always visible) ───────────────────────────────────
class _TrainingPlanSection extends StatelessWidget {
  const _TrainingPlanSection({required this.activePlan});

  final TrainingPlan? activePlan;

  TrainingPlanWorkout? get _todayWorkout {
    final plan = activePlan;
    if (plan == null || plan.currentWeek == null || plan.currentDay == null) {
      return null;
    }
    final weekMatches =
        plan.weeks.where((w) => w.weekNumber == plan.currentWeek).toList();
    if (weekMatches.isEmpty) return null;
    final dayMatches = weekMatches.first.workouts
        .where((w) => w.dayNumber == plan.currentDay)
        .toList();
    return dayMatches.isEmpty ? null : dayMatches.first;
  }

  @override
  Widget build(BuildContext context) {
    final plan = activePlan;
    final today = _todayWorkout;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Text(
            'Plan de entrenamiento',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.midGray,
              letterSpacing: 0.8,
            ),
          ),
        ),
        if (plan == null)
          // ── No active plan — show CTA ───────────────────────────────
          FynixCard(
            onTap: () => context.push(Routes.trainingPlans),
            border: Border.all(
              color: AppColors.aiAccent.withAlpha(50),
              width: 1.5,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.aiAccent.withAlpha(28),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: const Icon(
                    Icons.route_rounded,
                    color: AppColors.aiAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Empieza un plan de entrenamiento',
                        style: AppTypography.bodyMedium,
                      ),
                      Text(
                        'Planes de 5k, 10k, media maratón y más',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.midGray,
                  size: 20,
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.05, end: 0, duration: 300.ms)
        else
          // ── Active plan — show today's workout ──────────────────────
          FynixCard(
            border: Border.all(
              color: AppColors.aiAccent.withAlpha(60),
              width: 1.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.aiAccent.withAlpha(28),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: const Icon(
                        Icons.route_rounded,
                        color: AppColors.aiAccent,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plan.title, style: AppTypography.bodyMedium),
                          if (plan.currentWeek != null &&
                              plan.currentDay != null)
                            Text(
                              'Semana ${plan.currentWeek} · Día ${plan.currentDay}',
                              style: AppTypography.labelSmall,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (today != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                      border: Border.all(color: AppColors.borderHairline),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.today_rounded,
                          size: 14,
                          color: AppColors.gold,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            today.title,
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        if (today.targetDistanceMeters != null)
                          Text(
                            DistanceFormatter.formatKm(
                              today.targetDistanceMeters!.toDouble(),
                            ),
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.gold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: () => context.push(Routes.trainingPlans),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Ver plan completo',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.aiAccent,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: AppColors.aiAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.05, end: 0, duration: 300.ms),
      ],
    );
  }
}

// ─── Time toggle ──────────────────────────────────────────────────────────────
class _TimeToggle extends StatelessWidget {
  const _TimeToggle({required this.selected, required this.onChanged});

  final _TimeRange selected;
  final ValueChanged<_TimeRange> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.darkEmber,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: 'Semanal',
            active: selected == _TimeRange.weekly,
            onTap: () => onChanged(_TimeRange.weekly),
          ),
          _ToggleOption(
            label: 'Mensual',
            active: selected == _TimeRange.monthly,
            onTap: () => onChanged(_TimeRange.monthly),
          ),
          _ToggleOption(
            label: 'Anual',
            active: selected == _TimeRange.yearly,
            onTap: () => onChanged(_TimeRange.yearly),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.gold : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: active ? AppColors.obsidian : AppColors.midGray,
              fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Sport filter pills ───────────────────────────────────────────────────────
class _SportFilterRow extends StatelessWidget {
  const _SportFilterRow({required this.selected, required this.onChanged});

  final WorkoutSportType? selected;
  final ValueChanged<WorkoutSportType?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _SportPill(
            label: 'Todos',
            icon: Icons.apps_rounded,
            active: selected == null,
            onTap: () => onChanged(null),
          ),
          const SizedBox(width: AppSpacing.xs),
          _SportPill(
            label: 'Running',
            icon: Icons.directions_run_rounded,
            active: selected == WorkoutSportType.running,
            onTap: () => onChanged(WorkoutSportType.running),
          ),
          const SizedBox(width: AppSpacing.xs),
          _SportPill(
            label: 'Ciclismo',
            icon: Icons.directions_bike_rounded,
            active: selected == WorkoutSportType.cycling,
            onTap: () => onChanged(WorkoutSportType.cycling),
          ),
          const SizedBox(width: AppSpacing.xs),
          _SportPill(
            label: 'Natación',
            icon: Icons.pool_rounded,
            active: selected == WorkoutSportType.swimming,
            onTap: () => onChanged(WorkoutSportType.swimming),
          ),
          const SizedBox(width: AppSpacing.xs),
          _SportPill(
            label: 'Fuerza',
            icon: Icons.fitness_center_rounded,
            active: selected == WorkoutSportType.strength,
            onTap: () => onChanged(WorkoutSportType.strength),
          ),
        ],
      ),
    );
  }
}

class _SportPill extends StatelessWidget {
  const _SportPill({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.gold : AppColors.darkEmber,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? AppColors.gold : AppColors.borderHairline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: active ? AppColors.obsidian : AppColors.midGray,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: active ? AppColors.obsidian : AppColors.midGray,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat card ────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.unit,
    required this.label,
    required this.color,
  });

  final String value;
  final String unit;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 3,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          RichText(
            text: TextSpan(
              text: value,
              style: AppTypography.statLarge.copyWith(
                color: AppColors.white,
                fontSize: 22,
              ),
              children: unit.isNotEmpty
                  ? [
                      TextSpan(
                        text: ' $unit',
                        style: AppTypography.labelSmall.copyWith(
                          color: color,
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}

// ─── Distance chart ───────────────────────────────────────────────────────────
class _DistanceChart extends StatelessWidget {
  const _DistanceChart({required this.workouts, required this.range});

  final List<Workout> workouts;
  final _TimeRange range;

  List<BarChartGroupData> _buildGroups() {
    final now = DateTime.now();

    if (range == _TimeRange.weekly) {
      // 7 bars — one per day
      final Map<int, double> dayKm = {for (var i = 0; i < 7; i++) i: 0.0};
      for (final w in workouts) {
        final diff = now.difference(w.startedAt).inDays;
        if (diff < 7) {
          dayKm[6 - diff] = (dayKm[6 - diff] ?? 0) + w.distanceMeters / 1000;
        }
      }
      return _toGroups(dayKm, barWidth: 18, radius: 4);
    } else if (range == _TimeRange.monthly) {
      // 4 bars — one per week
      final Map<int, double> weekKm = {for (var i = 0; i < 4; i++) i: 0.0};
      for (final w in workouts) {
        final diff = now.difference(w.startedAt).inDays;
        if (diff < 28) {
          final weekIdx = (diff / 7).floor().clamp(0, 3);
          weekKm[3 - weekIdx] =
              (weekKm[3 - weekIdx] ?? 0) + w.distanceMeters / 1000;
        }
      }
      return _toGroups(weekKm, barWidth: 36, radius: 4);
    } else {
      // 12 bars — one per month of current year
      final Map<int, double> monthKm = {for (var i = 0; i < 12; i++) i: 0.0};
      for (final w in workouts) {
        final monthIdx = w.startedAt.month - 1;
        monthKm[monthIdx] =
            (monthKm[monthIdx] ?? 0) + w.distanceMeters / 1000;
      }
      return _toGroups(monthKm, barWidth: 14, radius: 3);
    }
  }

  List<BarChartGroupData> _toGroups(
    Map<int, double> data, {
    required double barWidth,
    required double radius,
  }) {
    return data.entries
        .map(
          (e) => BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value,
                gradient: e.value > 0
                    ? const LinearGradient(
                        colors: [AppColors.flameCoral, AppColors.gold],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )
                    : null,
                color: e.value > 0 ? null : AppColors.ember,
                width: barWidth,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  List<String> get _labels {
    switch (range) {
      case _TimeRange.weekly:
        return ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
      case _TimeRange.monthly:
        return ['S-4', 'S-3', 'S-2', 'S-1'];
      case _TimeRange.yearly:
        return ['En', 'Fe', 'Ma', 'Ab', 'My', 'Jn', 'Jl', 'Ag', 'Se', 'Oc', 'No', 'Di'];
    }
  }

  bool get _hasData => workouts.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!_hasData) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 40,
              color: AppColors.midGray.withAlpha(80),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Sin datos para este período',
              style: AppTypography.bodySmall,
            ),
          ],
        ),
      );
    }

    final groups = _buildGroups();
    final maxY = groups
        .expand((g) => g.barRods.map((r) => r.toY))
        .fold<double>(0, (m, v) => v > m ? v : m);
    final labels = _labels;

    return BarChart(
      BarChartData(
        maxY: maxY * 1.3 + 1,
        minY: 0,
        barGroups: groups,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => const FlLine(
            color: AppColors.ember,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= labels.length) return const SizedBox();
                return Text(
                  labels[idx],
                  style: AppTypography.labelSmall,
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.darkEmber,
            tooltipRoundedRadius: AppSpacing.radiusSm,
            getTooltipItem: (group, _, rod, __) {
              if (rod.toY == 0) return null;
              return BarTooltipItem(
                '${rod.toY.toStringAsFixed(1)} km',
                AppTypography.labelSmall.copyWith(color: AppColors.gold),
              );
            },
          ),
        ),
      ),
    );
  }
}

Color _workoutRouteAccent(WorkoutSportType sport) {
  switch (sport) {
    case WorkoutSportType.cycling:
      return AppColors.flameCoral;
    case WorkoutSportType.swimming:
      return AppColors.aiAccent;
    default:
      return AppColors.gold;
  }
}

bool _workoutHasRouteData(Workout w) =>
    (w.polyline != null && w.polyline!.isNotEmpty) ||
    (w.mapSnapshotUrl != null && w.mapSnapshotUrl!.isNotEmpty);

// ─── Workout card ─────────────────────────────────────────────────────────────
class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.workout, required this.onTap});

  final Workout workout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showRoute = _workoutHasRouteData(workout);

    return FynixCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showRoute) ...[
            ActivityRoutePreviewStrip(
              accentColor: _workoutRouteAccent(workout.sportType),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(28),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Center(
                  child: SportIcon(
                    sport: workout.sportType,
                    color: AppColors.gold,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name ?? SportIcon.labelFor(workout.sportType),
                      style: AppTypography.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${DistanceFormatter.formatKm(workout.distanceMeters)} • ${PaceFormatter.formatDurationHuman(workout.durationSeconds)}',
                      style: AppTypography.bodySmall,
                    ),
                    Text(
                      DateHelpers.formatRelative(workout.startedAt),
                      style: AppTypography.labelSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+${workout.xpEarned} XP',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.xpGreen,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.midGray,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.directions_run_rounded,
                size: 48,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Sin actividades', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Conecta Strava o Apple Health\npara sincronizar tus entrenamientos',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
