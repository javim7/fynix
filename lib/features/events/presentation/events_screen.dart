import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/race_event.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/events/data/events_repository.dart';

part 'events_screen.g.dart';

@riverpod
Future<List<RaceEvent>> upcomingEvents(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  return ref.read(eventsRepositoryProvider).fetchUpcomingEvents(userId: user?.id);
}

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(upcomingEventsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Eventos y Carreras')),
      body: eventsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (events) => events.isEmpty
            ? Center(
                child: Text('Sin eventos próximos', style: AppTypography.bodySmall))
            : ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: events.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, i) => _EventCard(
                  event: events[i],
                  onTap: () => context.push('/events/${events[i].id}'),
                ),
              ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.onTap});

  final RaceEvent event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final distanceKm = event.distanceMeters != null
        ? '${(event.distanceMeters! / 1000).toStringAsFixed(0)} km'
        : null;

    return FynixCard(
      onTap: onTap,
      border: event.isFeatured
          ? Border.all(color: AppColors.gold.withAlpha(100))
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (event.isFeatured)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: 2),
              margin: const EdgeInsets.only(bottom: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Text(
                'Destacado',
                style:
                    AppTypography.labelSmall.copyWith(color: AppColors.obsidian),
              ),
            ),
          Text(event.title, style: AppTypography.h4),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded,
                  size: 12, color: AppColors.midGray),
              const SizedBox(width: 4),
              Text(
                '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}',
                style: AppTypography.bodySmall,
              ),
              if (event.city != null) ...[
                const SizedBox(width: AppSpacing.sm),
                const Icon(Icons.location_on_rounded,
                    size: 12, color: AppColors.midGray),
                const SizedBox(width: 4),
                Text(event.city!, style: AppTypography.bodySmall),
              ],
              if (distanceKm != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Text(distanceKm, style: AppTypography.labelMedium),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '+${event.xpReward} XP al completar',
                    style: AppTypography.labelMedium.copyWith(color: AppColors.gold),
                  ),
                  if (event.embersSignupCost > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            size: 12,
                            color: AppColors.flameCoral,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${event.embersSignupCost} Embers para unirte',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.flameCoral,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (event.isRegistered)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withAlpha(30),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusSm),
                    border: Border.all(color: AppColors.success),
                  ),
                  child: Text(
                    'Inscrito',
                    style: AppTypography.labelSmall
                        .copyWith(color: AppColors.success),
                  ),
                )
              else
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.midGray),
            ],
          ),
        ],
      ),
    );
  }
}
