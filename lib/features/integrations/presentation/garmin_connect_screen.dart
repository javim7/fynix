import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/services/garmin_service.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

/// Coming soon screen for Garmin Connect integration.
class GarminConnectScreen extends StatelessWidget {
  const GarminConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Garmin Connect')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF009CDE).withAlpha(30),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: const Icon(Icons.watch_rounded,
                  color: Color(0xFF009CDE), size: 40),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Garmin Connect', style: AppTypography.h2),
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
                GarminService.comingSoonMessage,
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
