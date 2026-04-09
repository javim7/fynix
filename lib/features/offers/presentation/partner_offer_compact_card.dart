import 'package:flutter/material.dart';

import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';
import 'package:fynix/core/dev/mock_data.dart';
import 'package:fynix/core/widgets/fynix_card.dart';

/// Narrow card for the Home horizontal “Beneficios” carousel.
class PartnerOfferCompactCard extends StatelessWidget {
  const PartnerOfferCompactCard({
    super.key,
    required this.offer,
    this.onTap,
  });

  final PartnerOffer offer;
  final VoidCallback? onTap;

  String _expiryShort(int days) {
    if (days <= 0) return 'Últimas horas';
    if (days == 1) return '1 día';
    return '$days días';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 196,
      child: FynixCard(
        onTap: onTap,
        padding: const EdgeInsets.all(AppSpacing.sm + 2),
        glowColor: AppColors.gold.withAlpha(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  offer.brandEmoji ?? '🏷️',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    offer.brandName,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.midGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              offer.title,
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 12,
                  color: AppColors.flameCoral.withAlpha(200),
                ),
                const SizedBox(width: 2),
                Text(
                  _expiryShort(offer.expiresInDays),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.flameCoral,
                  ),
                ),
                if (offer.embersBonus != null) ...[
                  const Spacer(),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
