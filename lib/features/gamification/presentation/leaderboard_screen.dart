import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/gamification/domain/badge_notifier.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardAsync = ref.watch(weeklyLeaderboardProvider);
    final currentUser = ref.watch(authNotifierProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Clasificación semanal')),
      body: boardAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (rows) {
          if (rows.isEmpty) {
            return const Center(
              child: Text(
                'Aún no hay datos esta semana',
                style: AppTypography.bodySmall,
              ),
            );
          }

          final podium = rows.take(3).toList();
          final rest = rows.skip(3).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.xl,
            ),
            children: [
              // ── Podium (top 3) ────────────────────────────────────────────
              if (podium.isNotEmpty) ...[
                Text(
                  'TOP 3',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.midGray,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ...podium.asMap().entries.map((e) {
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
                      isPodium: true,
                    ),
                  );
                }),
                const SizedBox(height: AppSpacing.md),
                if (rest.isNotEmpty)
                  Container(
                    height: 1,
                    color: AppColors.borderHairline,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  ),
              ],

              // ── Rest of leaderboard ───────────────────────────────────────
              ...rest.asMap().entries.map((e) {
                final row = e.value;
                final rank = e.key + 4;
                final user = row['user'] as Map<String, dynamic>?;
                final isMe = user?['id'] == currentUser?.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _LeaderRow(
                    rank: rank,
                    user: user,
                    xp: row['total_xp'],
                    isMe: isMe,
                    isPodium: false,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _LeaderRow extends StatelessWidget {
  const _LeaderRow({
    required this.rank,
    required this.user,
    required this.xp,
    required this.isMe,
    required this.isPodium,
  });

  final int rank;
  final Map<String, dynamic>? user;
  final dynamic xp;
  final bool isMe;
  final bool isPodium;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      border: isMe
          ? Border.all(color: AppColors.gold.withAlpha(80), width: 1.5)
          : isPodium
              ? Border.all(color: AppColors.borderHairline, width: 1)
              : null,
      glowColor: isMe ? AppColors.gold : null,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 36,
            child: _RankBadge(rank: rank),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Avatar
          FynixAvatar(
            displayName: user?['display_name'] as String?,
            size: 38,
            level: user?['level'] as int?,
            showLevelBadge: false,
          ),
          const SizedBox(width: AppSpacing.sm),

          // Name + username
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

          // XP
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
    if (rank == 1) {
      return const Icon(Icons.emoji_events_rounded, color: Color(0xFFFFD700), size: 24);
    }
    if (rank == 2) {
      return const Icon(Icons.emoji_events_rounded, color: Color(0xFFC0C0C0), size: 24);
    }
    if (rank == 3) {
      return const Icon(Icons.emoji_events_rounded, color: Color(0xFFCD7F32), size: 24);
    }
    return Text(
      '#$rank',
      style: AppTypography.labelMedium,
      textAlign: TextAlign.center,
    );
  }
}
