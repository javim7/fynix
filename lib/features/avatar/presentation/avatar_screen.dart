import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/models/user_profile.dart';
import 'package:fynix/core/widgets/fynix_avatar.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';
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
        setState(() => _selectedSkinId = null);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Apariencia equipada')),
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
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        title: const Text('Mi Fénix'),
        backgroundColor: AppColors.obsidian,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: skinsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'No se pudieron cargar las apariencias.\n$e',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.midGray),
            ),
          ),
        ),
        data: (skins) {
          final userLevel = user?.level ?? 1;
          final isPremium = user?.subscriptionTier.name == 'premium';
          final equippedId = user?.avatarId;
          final pendingEquip = _selectedSkinId != null &&
              _selectedSkinId != equippedId;

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.sm,
                          AppSpacing.md,
                          AppSpacing.md,
                        ),
                        child: _AvatarHeroRow(userLevel: userLevel),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        0,
                        AppSpacing.md,
                        AppSpacing.xs,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Estilos', style: AppTypography.h4),
                            Text(
                              '${skins.length} disponibles',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.midGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (skins.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'Aún no hay estilos en tu cuenta.',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.midGray,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.sm,
                          AppSpacing.md,
                          AppSpacing.md,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: AppSpacing.sm,
                            crossAxisSpacing: AppSpacing.sm,
                            childAspectRatio: 0.78,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, i) {
                              final skin = skins[i];
                              return _SkinTile(
                                skin: skin,
                                userLevel: userLevel,
                                isPremium: isPremium,
                                user: user,
                                isSelected: _selectedSkinId == skin['id'],
                                onTap: () {
                                  final skinLevel =
                                      skin['level_required'] as int;
                                  final skinPrem =
                                      skin['is_premium'] as bool;
                                  final locked = userLevel < skinLevel ||
                                      (skinPrem && !isPremium);
                                  if (locked) return;
                                  HapticFeedback.selectionClick();
                                  setState(
                                    () => _selectedSkinId =
                                        skin['id'] as String,
                                  );
                                },
                              );
                            },
                            childCount: skins.length,
                          ),
                        ),
                      ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: AppSpacing.xl),
                    ),
                  ],
                ),
              ),
              if (pendingEquip)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.md + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: FynixButton(
                    label: 'Equipar este estilo',
                    onPressed: _equip,
                    isLoading: _isSaving,
                    icon: Icons.check_rounded,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Compact hero: preview + short copy + roadmap chips (saves vertical space).
class _AvatarHeroRow extends StatelessWidget {
  const _AvatarHeroRow({required this.userLevel});

  final int userLevel;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      glowColor: AppColors.gold.withAlpha(40),
      border: Border.all(color: AppColors.gold.withAlpha(55)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PhoenixCharacterPreviewBadge(size: 88),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tu Fénix', style: AppTypography.h3),
                const SizedBox(height: 4),
                Text(
                  'Nivel $userLevel · Elige un estilo base. Ropa, calzado y equipamiento llegarán en actualizaciones.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.midGray,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: const [
                    _SoonCategoryChip(label: 'Ropa'),
                    _SoonCategoryChip(label: 'Calzado'),
                    _SoonCategoryChip(label: 'Bicis'),
                    _SoonCategoryChip(label: 'Accesorios'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SoonCategoryChip extends StatelessWidget {
  const _SoonCategoryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.labelSmall),
          const SizedBox(width: 4),
          Text(
            'Pronto',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.midGray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkinTile extends StatelessWidget {
  const _SkinTile({
    required this.skin,
    required this.userLevel,
    required this.isPremium,
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  final Map<String, dynamic> skin;
  final int userLevel;
  final bool isPremium;
  final UserProfile? user;
  final bool isSelected;
  final VoidCallback onTap;

  static const _logoAsset = 'assets/icons/fynixIcon3.png';

  @override
  Widget build(BuildContext context) {
    final id = skin['id'] as String;
    final isEquipped = user?.avatarId == id;
    final skinLevel = skin['level_required'] as int;
    final skinPremium = skin['is_premium'] as bool;
    final isLocked = userLevel < skinLevel || (skinPremium && !isPremium);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.darkEmber,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
              if (isLocked)
                Icon(
                  Icons.lock_rounded,
                  color: AppColors.midGray,
                  size: 32,
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.gold.withAlpha(100),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipOval(
                    child: Image.asset(
                      _logoAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.gold,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              Text(
                skin['name'] as String,
                style: AppTypography.labelSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (isLocked)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    skinPremium ? 'Premium' : 'Nv. $skinLevel',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.flameCoral,
                    ),
                  ),
                ),
              if (isEquipped)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'Activo',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.flameCoral,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
