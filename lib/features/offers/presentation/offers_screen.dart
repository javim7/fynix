import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/widgets/fynix_button.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  /// `null` = all categories.
  String? _tagFilter;

  static const _chipTags = <(String?, String)>[
    (null, 'Todos'),
    ('running', 'Running'),
    ('cycling', 'Ciclismo'),
    ('nutrition', 'Nutrición'),
    ('events', 'Eventos'),
  ];

  List<PartnerOffer> get _filtered {
    if (_tagFilter == null) return kMockPartnerOffers.toList();
    return kMockPartnerOffers
        .where((o) => o.tags.contains(_tagFilter))
        .toList();
  }

  PartnerOffer? get _heroOffer {
    final list = _filtered;
    if (list.isEmpty) return null;
    for (final o in list) {
      if (o.isFeatured) return o;
    }
    return list.first;
  }

  List<PartnerOffer> get _listOffers {
    final hero = _heroOffer;
    if (hero == null) return [];
    return _filtered.where((o) => o.id != hero.id).toList();
  }

  String _expiryLabel(int days) {
    if (days <= 0) return 'Últimas horas';
    if (days == 1) return 'Termina mañana';
    return 'Termina en $days días';
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hero = _heroOffer;
    final rest = _listOffers;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.obsidian,
            floating: true,
            title: const Text('Beneficios'),
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
                Text(
                  'Marcas aliadas y ofertas para tu próximo entreno',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.midGray,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _chipTags.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.xs),
                    itemBuilder: (context, i) {
                      final (tag, label) = _chipTags[i];
                      final selected = _tagFilter == tag;
                      return FilterChip(
                        label: Text(label),
                        selected: selected,
                        onSelected: (_) =>
                            setState(() => _tagFilter = tag),
                        showCheckmark: false,
                        selectedColor: AppColors.gold.withAlpha(48),
                        backgroundColor: AppColors.darkEmber,
                        side: BorderSide(
                          color: selected
                              ? AppColors.gold.withAlpha(140)
                              : AppColors.borderHairline,
                        ),
                        labelStyle: AppTypography.labelMedium.copyWith(
                          color: selected ? AppColors.gold : AppColors.midGray,
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (hero != null) ...[
                  _HeroOfferCard(
                    offer: hero,
                    expiryLabel: _expiryLabel(hero.expiresInDays),
                    onCta: () => _openUrl(hero.ctaUrl),
                  )
                      .animate()
                      .fadeIn(duration: 350.ms)
                      .slideY(begin: 0.04, end: 0, duration: 350.ms),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Más ofertas',
                    style: AppTypography.h4,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                if (hero == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Center(
                      child: Text(
                        'No hay ofertas en esta categoría por ahora.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.midGray,
                        ),
                      ),
                    ),
                  ),
                ...rest.asMap().entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _OfferListCard(
                          offer: e.value,
                          expiryLabel: _expiryLabel(e.value.expiresInDays),
                          onCta: () => _openUrl(e.value.ctaUrl),
                        )
                            .animate(delay: (60 * e.key).ms)
                            .fadeIn(duration: 280.ms)
                            .slideY(begin: 0.04, end: 0, duration: 280.ms),
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

class _HeroOfferCard extends StatelessWidget {
  const _HeroOfferCard({
    required this.offer,
    required this.expiryLabel,
    required this.onCta,
  });

  final PartnerOffer offer;
  final String expiryLabel;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      glowColor: AppColors.gold,
      border: Border.all(color: AppColors.gold.withAlpha(80), width: 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.gold.withAlpha(24),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Text(
                  offer.brandEmoji ?? '✨',
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.flameCoral.withAlpha(28),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Destacado',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.flameCoral,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (offer.embersBonus != null) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface2,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.flameCoral.withAlpha(50),
                              ),
                            ),
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
                                  '+${offer.embersBonus} Embers al canjear',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.honey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(offer.brandName, style: AppTypography.labelMedium),
                    const SizedBox(height: 4),
                    Text(offer.title, style: AppTypography.h3),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            offer.subtitle,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.midGray,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: AppColors.flameCoral.withAlpha(220),
              ),
              const SizedBox(width: 4),
              Text(
                expiryLabel,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.flameCoral,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          FynixButton(
            label: 'Ver oferta',
            onPressed: onCta,
          ),
        ],
      ),
    );
  }
}

class _OfferListCard extends StatelessWidget {
  const _OfferListCard({
    required this.offer,
    required this.expiryLabel,
    required this.onCta,
  });

  final PartnerOffer offer;
  final String expiryLabel;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    return FynixCard(
      onTap: onCta,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              offer.brandEmoji ?? '🏷️',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.brandName,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.midGray,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  offer.title,
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  offer.subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.midGray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      expiryLabel,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.flameCoral,
                      ),
                    ),
                    if (offer.embersBonus != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.local_fire_department_rounded,
                        size: 12,
                        color: AppColors.flameCoral,
                      ),
                      Text(
                        '+${offer.embersBonus}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.flameCoral,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      'Ver oferta',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: AppColors.gold.withAlpha(200),
                    ),
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
