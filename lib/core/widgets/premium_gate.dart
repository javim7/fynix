import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/features/subscription/domain/subscription_notifier.dart';

/// Wraps premium-only content. Shows a paywall CTA if the user is not Premium.
///
/// Usage:
/// ```dart
/// PremiumGate(
///   child: AdvancedStatsWidget(),
/// )
/// ```
class PremiumGate extends ConsumerWidget {
  const PremiumGate({
    super.key,
    required this.child,
    this.featureName,
  });

  /// The premium content to show when the user has access.
  final Widget child;

  /// Optional feature name for the paywall CTA (e.g. "Planes de entrenamiento").
  final String? featureName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(subscriptionNotifierProvider).valueOrNull?.isPremium ?? false;

    if (isPremium) return child;

    return _PaywallCta(featureName: featureName);
  }
}

class _PaywallCta extends StatelessWidget {
  const _PaywallCta({this.featureName});

  final String? featureName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkEmber,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.gold.withAlpha(80)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.gold,
            size: 40,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            featureName != null
                ? '$featureName es Premium'
                : 'Función Premium',
            style: AppTypography.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Desbloquea todas las funciones por \$4.99/mes',
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          FynixButton(
            label: 'Ver planes',
            onPressed: () => context.push(Routes.paywall),
          ),
        ],
      ),
    );
  }
}
