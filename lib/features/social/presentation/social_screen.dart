import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/gamification/domain/badge_notifier.dart';

enum _Segment { clubs, friends, local, global }

enum _Period { weekly, monthly, yearly }

class SocialScreen extends ConsumerStatefulWidget {
  const SocialScreen({super.key});

  @override
  ConsumerState<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<SocialScreen> {
  _Segment _segment = _Segment.global;
  _Period _period = _Period.weekly;

  @override
  Widget build(BuildContext context) {
    final boardAsync = ref.watch(weeklyLeaderboardProvider);
    final currentUser = ref.watch(authNotifierProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clasificación'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_search_rounded),
            tooltip: 'Descubrir atletas',
            onPressed: () => context.push(Routes.discover),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        children: [
          // ── Segment pills ─────────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _SegmentPill(
                  label: 'Global',
                  icon: Icons.public_rounded,
                  active: _segment == _Segment.global,
                  onTap: () => setState(() => _segment = _Segment.global),
                ),
                const SizedBox(width: AppSpacing.xs),
                _SegmentPill(
                  label: 'Amigos',
                  icon: Icons.people_rounded,
                  active: _segment == _Segment.friends,
                  onTap: () => setState(() => _segment = _Segment.friends),
                ),
                const SizedBox(width: AppSpacing.xs),
                _SegmentPill(
                  label: 'Local',
                  icon: Icons.location_on_rounded,
                  active: _segment == _Segment.local,
                  onTap: () => setState(() => _segment = _Segment.local),
                ),
                const SizedBox(width: AppSpacing.xs),
                _SegmentPill(
                  label: 'Clubs',
                  icon: Icons.groups_rounded,
                  active: _segment == _Segment.clubs,
                  onTap: () => setState(() => _segment = _Segment.clubs),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ── Period toggle ─────────────────────────────────────────────
          Container(
            height: 36,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.darkEmber,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.borderHairline),
            ),
            child: Row(
              children: [
                _PeriodOption(
                  label: 'Semanal',
                  active: _period == _Period.weekly,
                  onTap: () => setState(() => _period = _Period.weekly),
                ),
                _PeriodOption(
                  label: 'Mensual',
                  active: _period == _Period.monthly,
                  onTap: () => setState(() => _period = _Period.monthly),
                ),
                _PeriodOption(
                  label: 'Anual',
                  active: _period == _Period.yearly,
                  onTap: () => setState(() => _period = _Period.yearly),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Leaderboard rows ──────────────────────────────────────────
          boardAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            ),
            error: (e, _) => const _EmptyLeaderboard(),
            data: (rows) {
              if (rows.isEmpty) return const _EmptyLeaderboard();
              return Column(
                children: rows.asMap().entries.map((e) {
                  final row = e.value;
                  final rank = e.key + 1;
                  final user = row['user'] as Map<String, dynamic>?;
                  final isMe = user?['id'] == currentUser?.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _LeaderRow(
                      rank: rank,
                      user: user,
                      xp: row['total_xp'],
                      isMe: isMe,
                    ),
                  )
                      .animate(delay: (60 * e.key).ms)
                      .fadeIn(duration: 280.ms)
                      .slideY(begin: 0.05, end: 0, duration: 280.ms);
                }).toList(),
              );
            },
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── Full leaderboard CTA ──────────────────────────────────────
          FynixCard(
            onTap: () => context.push(Routes.leaderboard),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ver clasificación completa',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: AppColors.gold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Segment pill ────────────────────────────────────────────────────────────
class _SegmentPill extends StatelessWidget {
  const _SegmentPill({
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
            const SizedBox(width: 5),
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

// ─── Period toggle option ─────────────────────────────────────────────────────
class _PeriodOption extends StatelessWidget {
  const _PeriodOption({
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

// ─── Leaderboard row ──────────────────────────────────────────────────────────
class _LeaderRow extends StatelessWidget {
  const _LeaderRow({
    required this.rank,
    required this.user,
    required this.xp,
    required this.isMe,
  });

  final int rank;
  final Map<String, dynamic>? user;
  final dynamic xp;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      border: isMe
          ? Border.all(color: AppColors.gold.withAlpha(80), width: 1.5)
          : null,
      glowColor: isMe ? AppColors.gold : null,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          SizedBox(width: 32, child: _RankBadge(rank: rank)),
          const SizedBox(width: AppSpacing.sm),
          FynixAvatar(
            displayName: user?['display_name'] as String?,
            size: 36,
            level: user?['level'] as int?,
            showLevelBadge: false,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?['display_name'] as String? ?? 'Atleta',
                  style: AppTypography.bodyMedium.copyWith(
                    color: isMe ? AppColors.gold : AppColors.white,
                    fontWeight: isMe ? FontWeight.w600 : FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '@${user?['username'] ?? ''}',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
          ),
          Text(
            '$xp XP',
            style: AppTypography.labelLarge.copyWith(color: AppColors.gold),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});
  final int rank;

  @override
  Widget build(BuildContext context) {
    const medals = {
      1: Color(0xFFFFD700),
      2: Color(0xFFC0C0C0),
      3: Color(0xFFCD7F32),
    };
    if (medals.containsKey(rank)) {
      return Icon(Icons.emoji_events_rounded, color: medals[rank], size: 22);
    }
    return Text(
      '#$rank',
      style: AppTypography.labelMedium,
      textAlign: TextAlign.center,
    );
  }
}

class _EmptyLeaderboard extends StatelessWidget {
  const _EmptyLeaderboard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Center(
        child: Text(
          'Aún no hay datos para este período',
          style: AppTypography.bodySmall,
        ),
      ),
    );
  }
}
