import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/xp_event.dart';
import 'package:fynix/core/utils/date_helpers.dart';
import 'package:fynix/features/gamification/domain/streak_notifier.dart';

class XpHistoryScreen extends ConsumerWidget {
  const XpHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(xpHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de XP')),
      body: historyAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (events) => events.isEmpty
            ? Center(
                child: Text('Sin historial aún', style: AppTypography.bodySmall))
            : ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: events.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.ember),
                itemBuilder: (context, i) => _XpEventTile(event: events[i]),
              ),
      ),
    );
  }
}

class _XpEventTile extends StatelessWidget {
  const _XpEventTile({required this.event});

  final XpEvent event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _sourceColor(event.source).withAlpha(30),
          shape: BoxShape.circle,
        ),
        child: Icon(_sourceIcon(event.source), color: _sourceColor(event.source), size: 20),
      ),
      title: Text(event.description, style: AppTypography.bodyMedium),
      subtitle: Text(
        DateHelpers.formatRelative(event.createdAt),
        style: AppTypography.labelSmall,
      ),
      trailing: Text(
        '+${event.xpAmount} XP',
        style: AppTypography.labelLarge.copyWith(color: AppColors.gold),
      ),
    );
  }

  IconData _sourceIcon(XpSource source) {
    switch (source) {
      case XpSource.workout:
        return Icons.directions_run_rounded;
      case XpSource.challenge:
        return Icons.local_fire_department_rounded;
      case XpSource.badge:
        return Icons.military_tech_rounded;
      case XpSource.event:
        return Icons.emoji_events_rounded;
      case XpSource.streakBonus:
        return Icons.whatshot_rounded;
      case XpSource.manual:
        return Icons.star_rounded;
    }
  }

  Color _sourceColor(XpSource source) {
    switch (source) {
      case XpSource.workout:
        return AppColors.gold;
      case XpSource.challenge:
        return AppColors.flameCoral;
      case XpSource.badge:
        return AppColors.honey;
      case XpSource.event:
        return AppColors.gold;
      case XpSource.streakBonus:
        return AppColors.flameCoral;
      case XpSource.manual:
        return AppColors.midGray;
    }
  }
}
