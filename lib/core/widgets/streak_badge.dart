import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_typography.dart';

/// Flame Coral streak indicator showing current streak days.
class StreakBadge extends StatelessWidget {
  const StreakBadge({
    super.key,
    required this.streakDays,
    this.size = StreakBadgeSize.medium,
    this.animate = false,
  });

  final int streakDays;
  final StreakBadgeSize size;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final isAlive = streakDays > 0;
    final color = isAlive ? AppColors.flameCoral : AppColors.midGray;

    final badge = _buildBadge(isAlive, color);

    if (!animate || !isAlive) return badge;

    return badge
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.07, 1.07),
          duration: 900.ms,
          curve: Curves.easeInOut,
        );
  }

  Widget _buildBadge(bool isAlive, Color color) {
    switch (size) {
      case StreakBadgeSize.small:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_fire_department_rounded, color: color, size: 14),
            const SizedBox(width: 2),
            Text(
              '$streakDays',
              style: AppTypography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );

      case StreakBadgeSize.medium:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isAlive
                ? AppColors.flameCoral.withAlpha(28)
                : AppColors.midGray.withAlpha(20),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withAlpha(isAlive ? 80 : 40),
            ),
            boxShadow: isAlive
                ? [
                    BoxShadow(
                      color: AppColors.flameCoral.withAlpha(40),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department_rounded, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                '$streakDays días',
                style: AppTypography.labelMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );

      case StreakBadgeSize.large:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAlive)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.flameCoral.withAlpha(28),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.flameCoral.withAlpha(60),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  color: color,
                  size: 48,
                ),
              )
            else
              Icon(
                Icons.local_fire_department_rounded,
                color: color,
                size: 48,
              ),
            const SizedBox(height: 4),
            Text(
              '$streakDays',
              style: AppTypography.statDisplay.copyWith(color: color),
            ),
            Text(
              streakDays == 1 ? 'día' : 'días',
              style: AppTypography.bodySmall.copyWith(color: color),
            ),
          ],
        );
    }
  }
}

enum StreakBadgeSize { small, medium, large }
