import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _selectedCategory = 'boost';

  static const _categories = [
    ('boost', 'Potenciadores', Icons.bolt_rounded),
    ('avatar', 'Avatar', Icons.face_rounded),
    ('title', 'Títulos', Icons.workspace_premium_rounded),
    ('embers', 'Embers', Icons.local_fire_department_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final items = kMockStoreItems
        .where((i) => i.category == _selectedCategory)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App bar ───────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: AppColors.obsidian,
            floating: true,
            title: const Text('Tienda'),
            actions: [
              // Ember balance pill
              Container(
                margin: const EdgeInsets.only(right: AppSpacing.sm),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.flameCoral.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColors.flameCoral.withAlpha(60)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: AppColors.flameCoral,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$kMockEmbers Embers',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.flameCoral,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.xl,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Category pills ────────────────────────────────────
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((cat) {
                      final (key, label, icon) = cat;
                      final selected = _selectedCategory == key;
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = key),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.gold
                                  : AppColors.darkEmber,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? AppColors.gold
                                    : AppColors.borderHairline,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  icon,
                                  size: 14,
                                  color: selected
                                      ? AppColors.obsidian
                                      : AppColors.midGray,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  label,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: selected
                                        ? AppColors.obsidian
                                        : AppColors.midGray,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // ── Section header (not shown for embers) ─────────────
                if (_selectedCategory != 'embers') ...[
                  _SectionHeader(category: _selectedCategory),
                  const SizedBox(height: AppSpacing.sm),
                ],

                // ── Items or Ember packages ────────────────────────────
                if (_selectedCategory == 'embers')
                  const _EmberPackagesSection()
                else
                  ...items.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _StoreItemCard(item: e.value)
                          .animate(delay: (60 * e.key).ms)
                          .fadeIn(duration: 280.ms)
                          .slideY(begin: 0.06, end: 0, duration: 280.ms),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final (title, subtitle, color) = switch (category) {
      'boost' => (
          'Potenciadores',
          'Multiplica tu XP y protege tu racha',
          AppColors.flameCoral,
        ),
      'avatar' => (
          'Personalización',
          'Marcos, auras y accesorios exclusivos',
          AppColors.aiAccent,
        ),
      _ => (
          'Títulos',
          'Muestra tus logros con títulos únicos',
          AppColors.gold,
        ),
    };

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(28),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            category == 'boost'
                ? Icons.bolt_rounded
                : category == 'avatar'
                    ? Icons.face_rounded
                    : Icons.workspace_premium_rounded,
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.h4),
            Text(subtitle, style: AppTypography.bodySmall),
          ],
        ),
      ],
    );
  }
}

// ─── Store item card ──────────────────────────────────────────────────────────
class _StoreItemCard extends StatelessWidget {
  const _StoreItemCard({required this.item});

  final MockStoreItem item;

  @override
  Widget build(BuildContext context) {
    final accentColor = item.category == 'boost'
        ? AppColors.flameCoral
        : item.category == 'avatar'
            ? AppColors.aiAccent
            : AppColors.gold;

    return FynixCard(
      border: item.isOwned
          ? Border.all(color: AppColors.xpGreen.withAlpha(100), width: 1.5)
          : null,
      child: Row(
        children: [
          // Icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accentColor.withAlpha(24),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(color: accentColor.withAlpha(60)),
            ),
            child: Center(
              child: Text(
                item.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Name + description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTypography.bodyMedium),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  style: AppTypography.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Price / owned badge
          if (item.isOwned)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.xpGreen.withAlpha(24),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: AppColors.xpGreen.withAlpha(80)),
              ),
              child: Text(
                'Tuyo',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.xpGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () => _showPurchaseSheet(context, item, accentColor),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentColor.withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: AppColors.flameCoral,
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${item.emberCost}',
                      style: AppTypography.labelSmall.copyWith(
                        color: accentColor,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showPurchaseSheet(
    BuildContext context,
    MockStoreItem item,
    Color accentColor,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkEmber,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.midGray.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Icon
            Text(item.icon, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: AppSpacing.sm),
            Text(item.name, style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(
              item.description,
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            // Cost row
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface0,
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tu saldo', style: AppTypography.bodySmall),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.flameCoral,
                        size: 14,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '$kMockEmbers Embers',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.flameCoral,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Buy button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: AppColors.obsidian,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${item.icon} ${item.name} añadido',
                        style: const TextStyle(color: AppColors.white),
                      ),
                      backgroundColor: AppColors.darkEmber,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Comprar · ${item.emberCost} Embers',
                      style: AppTypography.labelLarge.copyWith(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: AppColors.obsidian,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Ember IAP packages section ───────────────────────────────────────────────
class _EmberPackagesSection extends StatelessWidget {
  const _EmberPackagesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.flameCoral.withAlpha(28),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.flameCoral,
                size: 18,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Comprar Embers', style: AppTypography.h4),
                Text(
                  'Moneda premium · se procesa vía App Store',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Current balance
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.flameCoral.withAlpha(14),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.flameCoral.withAlpha(50)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tu saldo actual', style: AppTypography.bodySmall),
              Row(
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    color: AppColors.flameCoral,
                    size: 15,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$kMockEmbers Embers',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.flameCoral,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Package grid (2 columns)
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
          childAspectRatio: 0.85,
          children: kMockEmberPackages
              .asMap()
              .entries
              .map(
                (e) => _EmberPackageCard(package: e.value)
                    .animate(delay: (80 * e.key).ms)
                    .fadeIn(duration: 280.ms)
                    .slideY(begin: 0.06, end: 0, duration: 280.ms),
              )
              .toList(),
        ),

        const SizedBox(height: AppSpacing.sm),
        // Legal note
        Text(
          'Los precios son en USD e incluyen impuestos locales aplicables. Las compras se procesan a través de la App Store o Google Play.',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.midGray.withAlpha(160),
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ─── Ember package card ───────────────────────────────────────────────────────
class _EmberPackageCard extends StatelessWidget {
  const _EmberPackageCard({required this.package});

  final MockEmberPackage package;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showIapSheet(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: package.isPopular || package.isBestValue
              ? LinearGradient(
                  colors: package.isBestValue
                      ? [
                          AppColors.xpGreen.withAlpha(40),
                          AppColors.darkEmber,
                        ]
                      : [
                          AppColors.gold.withAlpha(40),
                          AppColors.darkEmber,
                        ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: package.isPopular || package.isBestValue
              ? null
              : AppColors.darkEmber,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: package.isBestValue
                ? AppColors.xpGreen.withAlpha(120)
                : package.isPopular
                    ? AppColors.gold.withAlpha(120)
                    : AppColors.borderHairline,
            width: package.isPopular || package.isBestValue ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge
              if (package.isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'POPULAR',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.obsidian,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                    ),
                  ),
                )
              else if (package.isBestValue)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.xpGreen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'MEJOR VALOR',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.obsidian,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                    ),
                  ),
                )
              else
                const SizedBox(height: 21),

              const Spacer(),

              // Ember icon
              const Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.flameCoral,
                size: 28,
              ),
              const SizedBox(height: 4),

              // Count
              Text(
                '${package.embers}',
                style: AppTypography.h2.copyWith(
                  color: AppColors.gold,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Embers',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.midGray,
                ),
              ),

              const Spacer(),

              // Price button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.flameCoral,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Center(
                  child: Text(
                    package.price,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIapSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.darkEmber,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.midGray.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.flameCoral,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${package.embers} Embers',
              style: AppTypography.h3.copyWith(color: AppColors.gold),
            ),
            const SizedBox(height: 4),
            Text(
              package.price,
              style: AppTypography.h4.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surface0,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.midGray,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Esta compra se procesará a través de la App Store o Google Play. Los Embers se añadirán a tu cuenta automáticamente.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.midGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.flameCoral,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '🔥 Compra procesada. Embers añadidos a tu cuenta.',
                      ),
                      backgroundColor: AppColors.darkEmber,
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                child: Text(
                  'Comprar ${package.price}',
                  style: AppTypography.labelLarge.copyWith(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
