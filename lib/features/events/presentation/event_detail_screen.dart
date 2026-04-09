import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/race_event.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/core/widgets/sport_icon.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/events/data/events_repository.dart';

part 'event_detail_screen.g.dart';

@riverpod
Future<RaceEvent?> eventDetail(Ref ref, String eventId) async {
  final user = await ref.watch(authNotifierProvider.future);
  return ref
      .read(eventsRepositoryProvider)
      .fetchEvent(eventId, userId: user?.id);
}

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del reto')),
      body: eventAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (event) {
          if (event == null) return const Center(child: Text('No encontrado'));
          return _EventDetailBody(event: event);
        },
      ),
    );
  }
}

class _EventDetailBody extends ConsumerStatefulWidget {
  const _EventDetailBody({required this.event});

  final RaceEvent event;

  @override
  ConsumerState<_EventDetailBody> createState() => _EventDetailBodyState();
}

class _EventDetailBodyState extends ConsumerState<_EventDetailBody> {
  bool _isRegistering = false;

  Future<void> _register() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;
    setState(() => _isRegistering = true);
    try {
      await ref.read(eventsRepositoryProvider).registerForEvent(
            userId: user.id,
            eventId: widget.event.id,
          );
      ref.invalidate(eventDetailProvider(widget.event.id));
      ref.invalidate(authNotifierProvider);
    } finally {
      if (mounted) setState(() => _isRegistering = false);
    }
  }

  String _distanceLabel(RaceEvent event) {
    if (event.distanceMeters == null) return 'Distancia variable';
    return '${(event.distanceMeters! / 1000).toStringAsFixed(1)} km';
  }

  String _windowLabel(RaceEvent event) {
    final s = event.matchWindowStart;
    final e = event.matchWindowEnd;
    if (s == null || e == null) {
      return '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}';
    }
    final fmt = DateFormat('d MMM yyyy, HH:mm');
    return '${fmt.format(s.toLocal())} — ${fmt.format(e.toLocal())}';
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final medalName = event.medalTitle?.isNotEmpty == true
        ? event.medalTitle!
        : 'Medalla ${event.title}';

    return SingleChildScrollView(
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
              _Chip(Icons.calendar_today_rounded,
                  '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}'),
              if (event.city != null)
                _Chip(Icons.location_on_rounded, event.city!),
              _Chip(Icons.straighten_rounded, _distanceLabel(event)),
              _Chip(
                Icons.directions_run_rounded,
                SportIcon.labelFor(event.sportType),
              ),
            ],
          ),
          if (event.isSimulation) ...[
            const SizedBox(height: AppSpacing.md),
            FynixCard(
              color: AppColors.flameCoral.withAlpha(20),
              border: Border.all(color: AppColors.flameCoral.withAlpha(70)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: AppColors.flameCoral, size: 22),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Reto inspirado en un evento real. Unirte aquí no sustituye '
                      'la inscripción oficial ni pagos al organizador.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.midGray,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (event.description != null && event.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Descripción', style: AppTypography.h4),
            const SizedBox(height: AppSpacing.xs),
            Text(event.description!, style: AppTypography.bodyMedium),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text('Reglas de validación', style: AppTypography.h4),
          const SizedBox(height: AppSpacing.sm),
          FynixCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RuleRow(
                  Icons.schedule_rounded,
                  'Ventana de actividad',
                  _windowLabel(event),
                ),
                const Divider(height: AppSpacing.lg, color: AppColors.borderHairline),
                _RuleRow(
                  Icons.straighten_rounded,
                  'Distancia objetivo',
                  '${_distanceLabel(event)} (±${event.distanceTolerancePercent.toStringAsFixed(0)}%)',
                ),
                if (event.venueLat != null && event.venueLng != null) ...[
                  const Divider(height: AppSpacing.lg, color: AppColors.borderHairline),
                  _RuleRow(
                    Icons.map_rounded,
                    'Ubicación',
                    'Inicio del entreno dentro de ~${(event.matchRadiusMeters / 1000).toStringAsFixed(0)} km del punto del evento.',
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Medalla digital', style: AppTypography.h4),
          const SizedBox(height: AppSpacing.sm),
          FynixCard(
            glowColor: AppColors.gold.withAlpha(45),
            border: Border.all(color: AppColors.gold.withAlpha(85)),
            child: Row(
              children: [
                const Text('🏅', style: TextStyle(fontSize: 52)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(medalName, style: AppTypography.h3),
                      const SizedBox(height: 4),
                      Text(
                        'Se otorga al completar el reto con una actividad que cumpla las reglas.',
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
                  '+${event.xpReward} XP',
                  style: AppTypography.statDisplay.copyWith(
                    color: AppColors.xpGreen,
                  ),
                ),
                if (event.bonusXpReward > 0)
                  Text(
                    '+${event.bonusXpReward} XP bonus podio',
                    style: AppTypography.bodySmall,
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (event.isRegistered)
            FynixButton(
              label: event.isCompleted
                  ? 'Reto completado'
                  : 'Ya estás inscrito en este reto',
              onPressed: null,
              variant: FynixButtonVariant.secondary,
              icon: Icons.check_circle_rounded,
            )
          else
            FynixButton(
              label: event.embersSignupCost > 0
                  ? 'Unirme al reto · ${event.embersSignupCost} Embers'
                  : 'Unirme al reto',
              onPressed: _register,
              isLoading: _isRegistering,
              icon: Icons.flag_rounded,
            ),
          if (event.registrationUrl != null &&
              event.registrationUrl!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            FynixButton(
              label: 'Inscripción oficial / más info (web)',
              variant: FynixButtonVariant.ghost,
              onPressed: () => launchUrl(
                Uri.parse(event.registrationUrl!),
                mode: LaunchMode.externalApplication,
              ),
              icon: Icons.open_in_new_rounded,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow(this.icon, this.title, this.subtitle);

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.gold),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.labelLarge),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.midGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
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
