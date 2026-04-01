import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/race_event.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
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
      appBar: AppBar(title: const Text('Evento')),
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
    } finally {
      if (mounted) setState(() => _isRegistering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final distanceKm = event.distanceMeters != null
        ? '${(event.distanceMeters! / 1000).toStringAsFixed(0)} km'
        : 'Distancia variable';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.title, style: AppTypography.h1),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              _Chip(Icons.calendar_today_rounded,
                  '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}'),
              if (event.city != null)
                _Chip(Icons.location_on_rounded, event.city!),
              _Chip(Icons.straighten_rounded, distanceKm),
            ],
          ),
          if (event.description != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(event.description!, style: AppTypography.bodyMedium),
          ],
          const SizedBox(height: AppSpacing.lg),
          FynixCard(
            border: Border.all(color: AppColors.gold.withAlpha(80)),
            child: Column(
              children: [
                Text('Recompensa por completar', style: AppTypography.labelMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('+${event.xpReward} XP', style: AppTypography.statDisplay),
                if (event.bonusXpReward > 0)
                  Text('+${event.bonusXpReward} XP bonus podio',
                      style: AppTypography.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (event.isRegistered)
            FynixButton(
              label: '¡Ya estás inscrito!',
              onPressed: null,
              variant: FynixButtonVariant.secondary,
              icon: Icons.check_circle_rounded,
            )
          else
            FynixButton(
              label: 'Inscribirme',
              onPressed: _register,
              isLoading: _isRegistering,
              icon: Icons.flag_rounded,
            ),
          if (event.registrationUrl != null) ...[
            const SizedBox(height: AppSpacing.sm),
            FynixButton(
              label: 'Más información',
              variant: FynixButtonVariant.ghost,
              onPressed: () => launchUrl(Uri.parse(event.registrationUrl!)),
              icon: Icons.open_in_new_rounded,
            ),
          ],
        ],
      ),
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
