import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/utils/distance_formatter.dart';
import 'package:fynix/core/utils/xp_calculator.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/streak_badge.dart';
import 'package:fynix/core/widgets/xp_bar.dart';
import 'package:fynix/core/dev/mock_user.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/profile/presentation/profile_clubs_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authNotifierProvider);

    return Scaffold(
      body: userAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) => _ProfileBody(user: user ?? kDevUser),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.user});

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
          title: Text('@${user.username}', style: AppTypography.h3),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              onPressed: () {},
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // ── Avatar + name ─────────────────────────────────────────────
              Row(
                children: [
                  FynixAvatar(
                    displayName: user.displayName,
                    size: 72,
                    level: user.level,
                    onTap: () => context.push(Routes.avatar),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.displayName, style: AppTypography.h2),
                        if (user.bio != null) ...[
                          const SizedBox(height: 2),
                          Text(user.bio!, style: AppTypography.bodySmall),
                        ],
                        if (user.city != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 12,
                                color: AppColors.midGray,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                user.city!,
                                style: AppTypography.labelSmall,
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: AppSpacing.xs),
                        StreakBadge(
                          streakDays: user.currentStreak,
                          size: StreakBadgeSize.small,
                          animate: user.currentStreak >= 7,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // ── XP card ───────────────────────────────────────────────────
              FynixCard(
                glowColor: AppColors.gold,
                child: XpBar(
                  level: user.level,
                  progress: progress,
                  currentXp: XpCalculator.xpIntoCurrentLevel(user.totalXp),
                  xpToNext: xpToNext,
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(
                    begin: 0.05,
                    end: 0,
                    duration: 400.ms,
                  ),
              const SizedBox(height: AppSpacing.md),

              // ── Stats grid ────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.straighten_rounded,
                      iconColor: AppColors.gold,
                      value: DistanceFormatter.formatKm(
                        user.totalDistanceMeters.toDouble(),
                      ),
                      label: 'Distancia',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.local_fire_department_rounded,
                      iconColor: AppColors.flameCoral,
                      value: '${user.longestStreak}d',
                      label: 'Racha máx.',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.directions_run_rounded,
                      iconColor: AppColors.xpGreen,
                      value: '${user.totalWorkouts}',
                      label: 'Entrenos',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // ── View Progress CTA ─────────────────────────────────────────
              FynixCard(
                onTap: () => context.go(Routes.workouts),
                border: Border.all(
                  color: AppColors.gold.withAlpha(60),
                  width: 1.5,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(28),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: const Icon(
                        Icons.bar_chart_rounded,
                        color: AppColors.gold,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ver Progreso',
                            style: AppTypography.h4,
                          ),
                          Text(
                            'Distancia, gráficas y actividades',
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
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Mi comunidad ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  'Mi comunidad',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.midGray,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              FynixCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _QuickLink(
                      icon: Icons.people_rounded,
                      iconColor: AppColors.aiAccent,
                      label: 'Seguidores',
                      onTap: () => context.push(Routes.followers),
                      trailing: Text(
                        '${user.followerCount}',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.midGray,
                        ),
                      ),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.person_add_rounded,
                      iconColor: AppColors.gold,
                      label: 'Siguiendo',
                      onTap: () => context.push(Routes.following),
                      trailing: Text(
                        '${user.followingCount}',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.midGray,
                        ),
                      ),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.groups_rounded,
                      iconColor: AppColors.flameCoral,
                      label: 'Clubs',
                      onTap: () => context.push(Routes.profileClubs),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Section header ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  'Mi cuenta',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.midGray,
                    letterSpacing: 0.8,
                  ),
                ),
              ),

              // ── Quick links ───────────────────────────────────────────────
              FynixCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _QuickLink(
                      icon: Icons.face_rounded,
                      iconColor: AppColors.aiAccent,
                      label: 'Avatar',
                      onTap: () => context.push(Routes.avatar),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.storefront_rounded,
                      iconColor: AppColors.gold,
                      label: 'Tienda',
                      onTap: () => context.push(Routes.store),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.military_tech_rounded,
                      iconColor: AppColors.flameCoral,
                      label: 'Mis insignias',
                      onTap: () => context.push(Routes.badges),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.link_rounded,
                      iconColor: AppColors.honey,
                      label: 'Integraciones',
                      onTap: () => context.push(Routes.integrations),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.bolt_rounded,
                      iconColor: AppColors.honey,
                      label: 'Historial de XP',
                      onTap: () => context.push(Routes.xpHistory),
                    ),
                    _Divider(),
                    _QuickLink(
                      icon: Icons.workspace_premium_rounded,
                      iconColor: AppColors.gold,
                      label: 'Plan Premium',
                      labelColor: AppColors.gold,
                      onTap: () => context.push(Routes.paywall),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.flameCoral, AppColors.gold],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(28),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.statLarge.copyWith(
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.trailing,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(28),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: labelColor,
                ),
              ),
            ),
            if (trailing != null) ...[
              trailing!,
              const SizedBox(width: AppSpacing.xs),
            ],
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.midGray,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      color: AppColors.borderHairline,
    );
  }
}
