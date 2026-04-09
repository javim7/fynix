import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/profile/data/medals_repository.dart';

part 'medals_screen.g.dart';

@riverpod
Future<List<UserMedalRecord>> myMedals(Ref ref) async {
  final user = await ref.watch(authNotifierProvider.future);
  if (user == null) return [];
  return ref.read(medalsRepositoryProvider).fetchUserMedals(user.id);
}

class MedalsScreen extends ConsumerWidget {
  const MedalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medalsAsync = ref.watch(myMedalsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Medallas digitales')),
      body: medalsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (medals) {
          if (medals.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  'Aún no tienes medallas.\nÚnete a un reto en Eventos y complétalo con una actividad válida.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.midGray,
                  ),
                ),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.82,
            ),
            itemCount: medals.length,
            itemBuilder: (context, i) {
              final m = medals[i];
              final dateStr = DateFormat('d MMM yyyy').format(m.earnedAt.toLocal());
              return FynixCard(
                glowColor: AppColors.gold.withAlpha(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _emojiForKey(m.medalAssetKey),
                      style: const TextStyle(fontSize: 44),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      m.medalTitle,
                      style: AppTypography.labelLarge,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateStr,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.midGray,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String _emojiForKey(String key) {
  switch (key) {
    case 'medal_default':
      return '🏅';
    default:
      return '🏅';
  }
}
