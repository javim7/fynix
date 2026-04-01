import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/dev/mock_user.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/xp_bar.dart';
import 'package:fynix/core/utils/xp_calculator.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authNotifierProvider);
    final user = userAsync.value ?? kDevUser;
    final progress = XpCalculator.levelProgress(user.totalXp);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App bar ─────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: AppColors.obsidian,
            floating: true,
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28 * 0.15),
                  child: Image.asset(
                    'assets/icons/fynixIcon3.png',
                    width: 28,
                    height: 28,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Text('Fynix'),
              ],
            ),
            actions: [
              // Embers balance
              Container(
                margin: const EdgeInsets.only(right: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.flameCoral.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.flameCoral.withAlpha(60)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: AppColors.flameCoral,
                      size: 15,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$kMockEmbers',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.flameCoral,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.xl,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Greeting + streak ──────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, ${user.displayName.split(' ').first} 👋',
                            style: AppTypography.h2,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.flameCoral,
                                size: 14,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Racha de ${user.currentStreak} días',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.flameCoral,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // League badge
                    GestureDetector(
                      onTap: () => context.go(Routes.league),
                      child: Column(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                                center: Alignment(-0.3, -0.3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withAlpha(80),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.emoji_events_rounded,
                              color: AppColors.obsidian,
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            kMockLeagueName,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.gold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // ── XP progress card ───────────────────────────────────
                FynixCard(
                  glowColor: AppColors.gold,
                  border: Border.all(color: AppColors.gold.withAlpha(40)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nivel ${user.level}',
                                style: AppTypography.h4.copyWith(
                                  color: AppColors.gold,
                                ),
                              ),
                              Text(
                                '$kMockXpThisLevel / $kMockXpNextLevel XP',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withAlpha(20),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.gold.withAlpha(60)),
                            ),
                            child: Text(
                              '${(progress * 100).toStringAsFixed(0)}%',
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      XpBar(
                        level: user.level,
                        progress: progress,
                        currentXp: kMockXpThisLevel,
                        xpToNext: kMockXpNextLevel - kMockXpThisLevel,
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: 0.05, end: 0, duration: 350.ms),
                const SizedBox(height: AppSpacing.sm),

                // ── League promotion alert ─────────────────────────────
                GestureDetector(
                  onTap: () => context.go(Routes.league),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1A0D),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                          color: AppColors.xpGreen.withAlpha(80), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.xpGreen.withAlpha(28),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.trending_up_rounded,
                            color: AppColors.xpGreen,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTypography.bodySmall,
                              children: [
                                const TextSpan(text: 'Estás a '),
                                TextSpan(
                                  text: '$kMockXpToPromotion XP ',
                                  style: const TextStyle(
                                    color: AppColors.xpGreen,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(text: 'de la promoción en '),
                                TextSpan(
                                  text: kMockLeagueName,
                                  style: const TextStyle(
                                    color: AppColors.gold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.xpGreen,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ).animate(delay: 100.ms).fadeIn(duration: 300.ms),
                const SizedBox(height: AppSpacing.md),

                // ── Quick actions ──────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Desafíos',
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.flameCoral,
                        onTap: () => context.go(Routes.challenges),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ActionButton(
                        label: 'Mi Liga',
                        icon: Icons.emoji_events_rounded,
                        color: AppColors.gold,
                        onTap: () => context.go(Routes.league),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ActionButton(
                        label: 'Tienda',
                        icon: Icons.storefront_rounded,
                        color: AppColors.aiAccent,
                        onTap: () => context.push(Routes.store),
                      ),
                    ),
                  ],
                ).animate(delay: 150.ms).fadeIn(duration: 300.ms),
                const SizedBox(height: AppSpacing.md),

                // ── Tu actividad reciente ──────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tu actividad', style: AppTypography.h4),
                    TextButton(
                      onPressed: () => context.go(Routes.workouts),
                      child: const Text('Ver todo'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),

                ...kMockActivities.asMap().entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _ActivityCard(activity: e.value)
                            .animate(delay: (80 * e.key + 200).ms)
                            .fadeIn(duration: 280.ms)
                            .slideY(begin: 0.06, end: 0, duration: 280.ms),
                      ),
                    ),
                const SizedBox(height: AppSpacing.xs),

                // ── En tu red ──────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('En tu red', style: AppTypography.h4),
                    TextButton(
                      onPressed: () => context.push(Routes.feed),
                      child: const Text('Ver feed'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),

                ...kMockFriendActivities.asMap().entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _FriendActivityCard(activity: e.value)
                            .animate(delay: (80 * e.key + 350).ms)
                            .fadeIn(duration: 280.ms)
                            .slideY(begin: 0.06, end: 0, duration: 280.ms),
                      ),
                    ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Action button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withAlpha(18),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withAlpha(60)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Friend activity card ─────────────────────────────────────────────────────
class _FriendActivityCard extends StatefulWidget {
  const _FriendActivityCard({required this.activity});

  final MockFriendActivity activity;

  @override
  State<_FriendActivityCard> createState() => _FriendActivityCardState();
}

class _FriendActivityCardState extends State<_FriendActivityCard> {
  late bool _liked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _liked = false;
    _likeCount = widget.activity.likeCount;
  }

  IconData get _sportIcon {
    switch (widget.activity.sport) {
      case 'running':
        return Icons.directions_run_rounded;
      case 'cycling':
        return Icons.directions_bike_rounded;
      case 'swimming':
        return Icons.pool_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }

  String get _timeLabel {
    if (widget.activity.daysAgo == 0) return 'Hoy';
    if (widget.activity.daysAgo == 1) return 'Ayer';
    return 'Hace ${widget.activity.daysAgo} días';
  }

  String get _initials {
    final parts = widget.activity.name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0][0];
  }

  void _toggleLike() {
    setState(() {
      _liked = !_liked;
      _likeCount += _liked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      child: Column(
        children: [
          // ── Top row: avatar + info + XP ─────────────────────────────
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.aiAccent, AppColors.flameCoral],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _initials,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.activity.name,
                          style: AppTypography.bodyMedium,
                        ),
                        const SizedBox(width: 6),
                        Icon(_sportIcon, color: AppColors.midGray, size: 13),
                      ],
                    ),
                    Text(
                      widget.activity.distanceKm > 0
                          ? '${widget.activity.distanceKm.toStringAsFixed(1)} km · ${widget.activity.durationMin} min · $_timeLabel'
                          : '${widget.activity.durationMin} min · $_timeLabel',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
              Text(
                '+${widget.activity.xpEarned} XP',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.xpGreen,
                ),
              ),
            ],
          ),

          // ── Divider ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Container(
              height: 1,
              color: AppColors.borderHairline,
            ),
          ),

          // ── Action row: like + comment ────────────────────────────────
          Row(
            children: [
              // Like button
              GestureDetector(
                onTap: _toggleLike,
                behavior: HitTestBehavior.opaque,
                child: AnimatedScale(
                  scale: _liked ? 1.0 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) => ScaleTransition(
                          scale: anim,
                          child: child,
                        ),
                        child: Icon(
                          _liked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          key: ValueKey(_liked),
                          color:
                              _liked ? AppColors.flameCoral : AppColors.midGray,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$_likeCount',
                        style: AppTypography.labelSmall.copyWith(
                          color:
                              _liked ? AppColors.flameCoral : AppColors.midGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Comment button
              GestureDetector(
                onTap: () => context.push(Routes.feed),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: AppColors.midGray,
                      size: 17,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.activity.commentCount}',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.midGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Activity card ────────────────────────────────────────────────────────────
class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final MockActivity activity;

  IconData get _icon {
    switch (activity.sport) {
      case 'running':
        return Icons.directions_run_rounded;
      case 'cycling':
        return Icons.directions_bike_rounded;
      default:
        return Icons.fitness_center_rounded;
    }
  }

  String get _timeLabel {
    if (activity.daysAgo == 0) return 'Hoy';
    if (activity.daysAgo == 1) return 'Ayer';
    return 'Hace ${activity.daysAgo} días';
  }

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(28),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(_icon, color: AppColors.gold, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.name, style: AppTypography.bodyMedium),
                Text(
                  '${activity.distanceKm.toStringAsFixed(1)} km · ${activity.durationMin} min · $_timeLabel',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '+${activity.xpEarned} XP',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.xpGreen,
            ),
          ),
        ],
      ),
    );
  }
}
