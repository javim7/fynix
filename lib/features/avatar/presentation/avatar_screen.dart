import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/features/auth/domain/auth_notifier.dart';
import 'package:fynix/features/avatar/data/avatar_repository.dart';

part 'avatar_screen.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> avatarSkins(Ref ref) async {
  return ref.read(avatarRepositoryProvider).fetchAllSkins();
}

class AvatarScreen extends ConsumerStatefulWidget {
  const AvatarScreen({super.key});

  @override
  ConsumerState<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends ConsumerState<AvatarScreen> {
  String? _selectedSkinId;
  bool _isSaving = false;

  Future<void> _equip() async {
    if (_selectedSkinId == null) return;
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;
    setState(() => _isSaving = true);
    try {
      await ref.read(avatarRepositoryProvider).equipSkin(
            userId: user.id,
            skinId: _selectedSkinId!,
          );
      ref.invalidate(authNotifierProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avatar actualizado')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final skinsAsync = ref.watch(avatarSkinsProvider);
    final user = ref.watch(authNotifierProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi avatar')),
      body: skinsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (skins) {
          final userLevel = user?.level ?? 1;
          final isPremium = user?.subscriptionTier.name == 'premium';

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                  ),
                  itemCount: skins.length,
                  itemBuilder: (context, i) {
                    final skin = skins[i];
                    final isEquipped = user?.avatarId == skin['id'];
                    final isSelected = _selectedSkinId == skin['id'];
                    final skinLevel = skin['level_required'] as int;
                    final skinPremium = skin['is_premium'] as bool;
                    final isLocked = userLevel < skinLevel ||
                        (skinPremium && !isPremium);

                    return GestureDetector(
                      onTap: isLocked
                          ? null
                          : () =>
                              setState(() => _selectedSkinId = skin['id'] as String),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: AppColors.darkEmber,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: isEquipped
                                ? AppColors.flameCoral
                                : isSelected
                                    ? AppColors.gold
                                    : AppColors.ember,
                            width: (isEquipped || isSelected) ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isLocked
                                  ? Icons.lock_rounded
                                  : Icons.person_rounded,
                              color: isLocked
                                  ? AppColors.midGray
                                  : AppColors.gold,
                              size: 36,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              skin['name'] as String,
                              style: AppTypography.labelSmall,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            if (isLocked)
                              Text(
                                skinPremium
                                    ? 'Premium'
                                    : 'Nv. $skinLevel',
                                style: AppTypography.labelSmall
                                    .copyWith(color: AppColors.flameCoral),
                              ),
                            if (isEquipped)
                              Text('Activo',
                                  style: AppTypography.labelSmall
                                      .copyWith(color: AppColors.flameCoral)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_selectedSkinId != null)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: FynixButton(
                    label: 'Equipar avatar',
                    onPressed: _equip,
                    isLoading: _isSaving,
                    icon: Icons.check_circle_rounded,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
