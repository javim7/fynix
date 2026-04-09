import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

/// Full detail for a [MockEvent] race shown from Retos → Eventos (simulated reto, not official signup).
class MockEventDetailScreen extends StatelessWidget {
  const MockEventDetailScreen({super.key, required this.event});

  final MockEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reto / evento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: AppTypography.h1),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                _Chip(Icons.calendar_today_rounded, event.raceDate),
                _Chip(Icons.location_on_rounded, event.location),
                _Chip(Icons.straighten_rounded, event.distance),
                _Chip(Icons.timer_rounded, 'Cierra en ${event.endsInDays} días'),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            FynixCard(
              color: AppColors.flameCoral.withAlpha(22),
              border: Border.all(color: AppColors.flameCoral.withAlpha(80)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: AppColors.flameCoral, size: 22),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Reto inspirado en un evento real. Unirte en Fynix no es '
                      'inscripción oficial ni pago a la organización: es un reto '
                      'en la app. Sincroniza un entreno que cumpla las reglas para '
                      'ganar XP y tu medalla digital.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.midGray,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Sobre el reto', style: AppTypography.h4),
            const SizedBox(height: AppSpacing.xs),
            Text(event.description, style: AppTypography.bodyMedium),
            const SizedBox(height: AppSpacing.lg),
            Text('Medalla digital', style: AppTypography.h4),
            const SizedBox(height: AppSpacing.sm),
            FynixCard(
              glowColor: AppColors.gold.withAlpha(40),
              border: Border.all(color: AppColors.gold.withAlpha(90)),
              child: Row(
                children: [
                  Text(event.medalEmoji, style: const TextStyle(fontSize: 56)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.medalTitle.isNotEmpty
                              ? event.medalTitle
                              : 'Medalla finisher',
                          style: AppTypography.h3,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Se desbloquea al completar el reto con una actividad válida.',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.midGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FynixCard(
              border: Border.all(color: AppColors.xpGreen.withAlpha(70)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('XP al completar', style: AppTypography.labelMedium),
                  const SizedBox(height: 6),
                  Text(
                    '+${event.xpReward > 0 ? event.xpReward : _xpFromReward(event.reward)} XP',
                    style: AppTypography.statDisplay.copyWith(
                      color: AppColors.xpGreen,
                    ),
                  ),
                  if (event.reward.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(event.reward, style: AppTypography.bodySmall),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FynixCard(
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department_rounded,
                      color: AppColors.flameCoral, size: 22),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unirse al reto', style: AppTypography.h4),
                        Text(
                          event.embersSignupCost > 0
                              ? '${event.embersSignupCost} Embers (compromiso en la app; se pueden devolver al completar según reglas Fynix).'
                              : 'Gratis en esta versión de demostración.',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.midGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (event.embersSignupCost > 0)
              FynixButton(
                label:
                    'Unirme al reto · ${event.embersSignupCost} Embers',
                icon: Icons.flag_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pronto: unirte desde aquí con Embers y validar con Strava.',
                      ),
                    ),
                  );
                },
              )
            else
              FynixButton(
                label: 'Unirme al reto',
                icon: Icons.flag_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pronto: unirte con Embers desde la app.'),
                    ),
                  );
                },
              ),
            if (event.officialInfoUrl.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              FynixButton(
                label: 'Inscripción oficial del evento (web)',
                variant: FynixButtonVariant.ghost,
                icon: Icons.open_in_new_rounded,
                onPressed: () => launchUrl(
                  Uri.parse(event.officialInfoUrl),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  static int _xpFromReward(String reward) {
    final m = RegExp(r'(\d+)\s*XP').firstMatch(reward);
    if (m != null) return int.tryParse(m.group(1)!) ?? 0;
    return 0;
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.ember,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.honey),
          const SizedBox(width: 4),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}
