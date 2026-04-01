import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/utils/xp_calculator.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/streak_badge.dart';
import 'package:fynix/core/widgets/xp_bar.dart';
import 'package:fynix/core/dev/mock_user.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authNotifierProvider);

    return Scaffold(
      body: userAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) => _DashboardBody(user: user ?? kDevUser),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final progress = XpCalculator.levelProgress(user.totalXp);
    final xpToNext = XpCalculator.xpToNextLevel(user.totalXp);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.obsidian,
          floating: true,
          title: const Text('Fynix', style: AppTypography.h3),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () {},
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // ── User header ──────────────────────────────────────────────
              _UserHeader(user: user),
              const SizedBox(height: AppSpacing.md),

              // ── XP bar ───────────────────────────────────────────────────
              FynixCard(
                child: XpBar(
                  level: user.level,
                  progress: progress,
                  currentXp: XpCalculator.xpIntoCurrentLevel(user.totalXp),
                  xpToNext: xpToNext,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Stats row ─────────────────────────────────────────────────
              _StatsRow(user: user),
              const SizedBox(height: AppSpacing.md),

              // ── Today's challenge CTA ─────────────────────────────────────
              _TodayChallengeCard(onTap: () => context.go(Routes.challenges)),
              const SizedBox(height: AppSpacing.md),

              // ── Recent activity header ────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Actividad reciente', style: AppTypography.h4),
                  TextButton(
                    onPressed: () => context.go(Routes.workouts),
                    child: const Text('Ver todo'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // Placeholder recent workouts list
              ...List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: FynixCard(
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(28),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: const Icon(Icons.directions_run_rounded, color: AppColors.gold),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Carrera matutina', style: AppTypography.bodyMedium),
                              Text('5.2 km • 28:45', style: AppTypography.bodySmall),
                            ],
                          ),
                        ),
                        Text('+52 XP', style: AppTypography.labelLarge.copyWith(color: AppColors.gold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ]),
          ),
        ),
      ],
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FynixAvatar(
          displayName: user.displayName,
          size: 56,
          level: user.level,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hola, ${user.displayName.split(' ').first}! 👋',
                  style: AppTypography.h3),
              Text('${user.totalXp} XP total', style: AppTypography.bodySmall),
            ],
          ),
        ),
        StreakBadge(
          streakDays: user.currentStreak,
          animate: user.currentStreak >= 7,
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Entrenos',
            value: '${user.totalWorkouts}',
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            label: 'Km totales',
            value: (user.totalDistanceMeters / 1000).toStringAsFixed(0),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            label: 'Racha',
            value: '${user.currentStreak}d',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      child: Column(
        children: [
          Text(value, style: AppTypography.statLarge),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}

class _TodayChallengeCard extends StatelessWidget {
  const _TodayChallengeCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      onTap: onTap,
      border: Border.all(color: AppColors.flameCoral.withAlpha(100)),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: AppColors.flameCoral,
            size: 32,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Desafío de hoy', style: AppTypography.h4),
                Text(
                  'Corre 5 km antes de medianoche',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('+50 XP', style: AppTypography.labelLarge.copyWith(color: AppColors.gold)),
              const Icon(Icons.chevron_right_rounded, color: AppColors.midGray),
            ],
          ),
        ],
      ),
    );
  }
}
