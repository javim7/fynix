import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/features/subscription/domain/subscription_notifier.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subAsync = ref.watch(subscriptionNotifierProvider);
    final isLoading = subAsync.isLoading;

    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Fynix Premium'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSpacing.lg),
            // Hero icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.flameCoral, AppColors.gold],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: const Icon(Icons.workspace_premium_rounded,
                  color: AppColors.white, size: 44),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Desbloquea todo Fynix', style: AppTypography.h1),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Planes de entrenamiento, estadísticas avanzadas\ny mucho más',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Features list
            ..._features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: AppColors.gold, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(f, style: AppTypography.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Monthly plan
            _PlanCard(
              title: 'Mensual',
              price: 'Q39.99 / mes',
              badge: null,
              onTap: isLoading
                  ? null
                  : () => ref
                      .read(subscriptionNotifierProvider.notifier)
                      .purchaseMonthly(),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Annual plan
            _PlanCard(
              title: 'Anual',
              price: 'Q319.99 / año',
              badge: 'Ahorra 33%',
              onTap: isLoading
                  ? null
                  : () => ref
                      .read(subscriptionNotifierProvider.notifier)
                      .purchaseAnnual(),
            ),
            const SizedBox(height: AppSpacing.lg),

            FynixButton(
              label: 'Restaurar compras',
              variant: FynixButtonVariant.ghost,
              onPressed: isLoading
                  ? null
                  : () => ref
                      .read(subscriptionNotifierProvider.notifier)
                      .restore(),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Se renovará automáticamente. Cancela cuando quieras.',
              style: AppTypography.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  static const List<String> _features = [
    'Conecta dispositivos ilimitados (Garmin, COROS, Strava)',
    'Planes de entrenamiento 5K, 10K y 21K',
    'Estadísticas avanzadas: zonas de ritmo, FC, elevación',
    'Reproducción de rutas en mapa',
    'Más de 30 skins de avatar',
    'Más de 50 insignias desbloqueables',
    'Freeze de racha semanal',
    'Misiones narrativas exclusivas',
    'Paquetes de preparación para eventos locales',
  ];
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.badge,
    required this.onTap,
  });

  final String title;
  final String price;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.darkEmber,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: badge != null ? AppColors.gold : AppColors.ember,
            width: badge != null ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.h4),
                  Text(price,
                      style:
                          AppTypography.bodyMedium.copyWith(color: AppColors.honey)),
                ],
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                ),
                child: Text(
                  badge!,
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.obsidian),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
