import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fynix/app/router.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/integration_connection.dart';
import 'package:fynix/core/models/workout.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/integrations/domain/integrations_notifier.dart';

class IntegrationsScreen extends ConsumerWidget {
  const IntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final integrationsAsync = ref.watch(integrationsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Integraciones')),
      body: integrationsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (integrations) {
          final connectedMap = {
            for (final i in integrations) i.provider: i,
          };

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text('Fuentes de salud', style: AppTypography.h4),
              const SizedBox(height: AppSpacing.sm),
              _IntegrationTile(
                provider: IntegrationProvider.appleHealth,
                connection: connectedMap[IntegrationProvider.appleHealth],
                label: 'Apple Health',
                subtitle: 'iPhone & Apple Watch',
                icon: Icons.favorite_rounded,
                iconColor: const Color(0xFFFF2D55),
                onTap: () {},
                isAvailable: true,
              ),
              const SizedBox(height: AppSpacing.sm),
              _IntegrationTile(
                provider: IntegrationProvider.googleFit,
                connection: connectedMap[IntegrationProvider.googleFit],
                label: 'Google Fit',
                subtitle: 'Android',
                icon: Icons.directions_run_rounded,
                iconColor: const Color(0xFF4285F4),
                onTap: () {},
                isAvailable: true,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Dispositivos y apps', style: AppTypography.h4),
              const SizedBox(height: AppSpacing.sm),
              _IntegrationTile(
                provider: IntegrationProvider.strava,
                connection: connectedMap[IntegrationProvider.strava],
                label: 'Strava',
                subtitle: 'GPS + segmentos + rutas',
                icon: Icons.directions_bike_rounded,
                iconColor: const Color(0xFFFC4C02),
                onTap: () => context.push(Routes.stravaConnect),
                isAvailable: true,
              ),
              const SizedBox(height: AppSpacing.sm),
              _IntegrationTile(
                provider: IntegrationProvider.garmin,
                connection: connectedMap[IntegrationProvider.garmin],
                label: 'Garmin Connect',
                subtitle: 'Próximamente',
                icon: Icons.watch_rounded,
                iconColor: const Color(0xFF009CDE),
                onTap: () => context.push(Routes.garminConnect),
                isAvailable: false,
              ),
              const SizedBox(height: AppSpacing.sm),
              _IntegrationTile(
                provider: IntegrationProvider.coros,
                connection: connectedMap[IntegrationProvider.coros],
                label: 'COROS',
                subtitle: 'Próximamente',
                icon: Icons.watch_rounded,
                iconColor: AppColors.gold,
                onTap: () => context.push(Routes.corosConnect),
                isAvailable: false,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IntegrationTile extends StatelessWidget {
  const _IntegrationTile({
    required this.provider,
    required this.connection,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.isAvailable,
  });

  final IntegrationProvider provider;
  final IntegrationConnection? connection;
  final String label;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isAvailable;

  bool get isConnected => connection?.isConnected ?? false;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      onTap: isAvailable ? onTap : null,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(30),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.bodyMedium),
                Text(
                  isConnected
                      ? 'Conectado${connection?.providerUsername != null ? ' • ${connection!.providerUsername}' : ''}'
                      : subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: isConnected ? AppColors.success : null,
                  ),
                ),
              ],
            ),
          ),
          if (!isAvailable)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.ember,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Text('Pronto', style: AppTypography.labelSmall),
            )
          else if (isConnected)
            const Icon(Icons.check_circle_rounded,
                color: AppColors.success, size: 20)
          else
            const Icon(Icons.chevron_right_rounded, color: AppColors.midGray),
        ],
      ),
    );
  }
}
