import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/badge_model.dart';
import 'package:fynix/core/widgets/premium_gate.dart';
import 'package:fynix/features/gamification/domain/badge_notifier.dart';

class BadgesScreen extends ConsumerWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgesAsync = ref.watch(userBadgesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Insignias')),
      body: badgesAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (badges) {
          final unlocked = badges.where((b) => b.isUnlocked).toList();
          final locked = badges.where((b) => !b.isUnlocked).toList();

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                'Desbloqueadas (${unlocked.length})',
                style: AppTypography.h4,
              ),
              const SizedBox(height: AppSpacing.sm),
              _BadgeGrid(badges: unlocked),
              const SizedBox(height: AppSpacing.lg),
              Text('Por desbloquear', style: AppTypography.h4),
              const SizedBox(height: AppSpacing.sm),
              // Premium badges need subscription
              _BadgeGrid(badges: locked.where((b) => !b.isPremium).toList()),
              if (locked.any((b) => b.isPremium)) ...[
                const SizedBox(height: AppSpacing.md),
                PremiumGate(
                  featureName: 'Insignias premium',
                  child: _BadgeGrid(
                      badges: locked.where((b) => b.isPremium).toList()),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _BadgeGrid extends StatelessWidget {
  const _BadgeGrid({required this.badges});

  final List<BadgeModel> badges;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return Text('Ninguna', style: AppTypography.bodySmall);
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: badges.length,
      itemBuilder: (context, i) => _BadgeTile(badge: badges[i]),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge});

  final BadgeModel badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.darkEmber,
          title: Text(badge.title, style: AppTypography.h4),
          content: Text(badge.description, style: AppTypography.bodySmall),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Opacity(
        opacity: badge.isUnlocked ? 1.0 : 0.35,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkEmber,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: badge.isUnlocked ? AppColors.gold : AppColors.ember,
              width: badge.isUnlocked ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                badge.isUnlocked
                    ? Icons.military_tech_rounded
                    : Icons.lock_rounded,
                color: badge.isUnlocked ? AppColors.gold : AppColors.midGray,
                size: 28,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  badge.title,
                  style: AppTypography.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
