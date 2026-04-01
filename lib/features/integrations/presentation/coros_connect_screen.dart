import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/services/coros_service.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

/// Coming soon screen for COROS integration.
class CorosConnectScreen extends StatelessWidget {
  const CorosConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('COROS')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.gold.withAlpha(30),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: const Icon(Icons.watch_rounded, color: AppColors.gold, size: 40),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('COROS', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.ember,
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              ),
              child: Text('Próximamente', style: AppTypography.labelMedium),
            ),
            const SizedBox(height: AppSpacing.xl),
            FynixCard(
              child: Text(
                CorosService.comingSoonMessage,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
