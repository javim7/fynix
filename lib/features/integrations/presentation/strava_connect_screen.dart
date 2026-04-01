import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/services/strava_service.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

class StravaConnectScreen extends ConsumerStatefulWidget {
  const StravaConnectScreen({super.key});

  @override
  ConsumerState<StravaConnectScreen> createState() =>
      _StravaConnectScreenState();
}

class _StravaConnectScreenState extends ConsumerState<StravaConnectScreen> {
  bool _isConnecting = false;

  Future<void> _connect() async {
    setState(() => _isConnecting = true);
    try {
      await ref.read(stravaServiceProvider).launchAuthUrl();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isConnecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conectar Strava')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFC4C02),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: const Icon(Icons.directions_run_rounded,
                  color: Colors.white, size: 40),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Strava', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Sincroniza todas tus actividades automáticamente',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            FynixCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¿Qué se sincroniza?', style: AppTypography.h4),
                  const SizedBox(height: AppSpacing.sm),
                  ...[
                    'Distancia, ritmo y duración',
                    'Frecuencia cardíaca y calorías',
                    'Ruta GPS y splits por kilómetro',
                    'Historial de 90 días al conectar',
                    'Actividades nuevas automáticamente',
                  ].map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              color: AppColors.success, size: 16),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(item, style: AppTypography.bodySmall),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            FynixButton(
              label: 'Conectar con Strava',
              onPressed: _connect,
              isLoading: _isConnecting,
              icon: Icons.link_rounded,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Serás redirigido a Strava para autorizar el acceso.',
              style: AppTypography.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
