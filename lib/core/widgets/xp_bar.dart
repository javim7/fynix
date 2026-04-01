import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/constants/app_spacing.dart';
import 'package:fynix/core/constants/app_typography.dart';

/// Animated Gold XP progress bar showing level progress.
class XpBar extends StatelessWidget {
  const XpBar({
    super.key,
    required this.level,
    required this.progress,
    required this.currentXp,
    required this.xpToNext,
    this.showLabels = true,
    this.height = 10.0,
    this.animate = true,
  });

  /// Current level (1–100).
  final int level;

  /// Progress within the current level (0.0–1.0).
  final double progress;

  /// XP earned within the current level.
  final int currentXp;

  /// XP remaining to next level.
  final int xpToNext;

  final bool showLabels;
  final double height;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabels) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withAlpha(28),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.gold.withAlpha(60),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Nv. $level',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '+$xpToNext XP → Nv. ${level + 1}',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.midGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        _XpProgressBar(
          progress: progress.clamp(0.0, 1.0),
          height: height,
          animate: animate,
        ),
      ],
    );
  }
}

class _XpProgressBar extends StatelessWidget {
  const _XpProgressBar({
    required this.progress,
    required this.height,
    required this.animate,
  });

  final double progress;
  final double height;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final bar = LayoutBuilder(
      builder: (context, constraints) {
        final fillWidth = constraints.maxWidth * progress;

        return ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Stack(
            children: [
              // Track
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.ember.withAlpha(100),
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
              // Fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                width: fillWidth,
                height: height,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.flameCoral, AppColors.gold],
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.goldGlow,
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              // Shine streak
              if (progress > 0.05)
                Positioned(
                  left: fillWidth - 6,
                  top: 1,
                  child: Container(
                    width: 3,
                    height: height - 2,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(80),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );

    if (!animate) return bar;

    return bar
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.04, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

/// Compact inline XP badge (e.g. "+37 XP").
class XpBurst extends StatelessWidget {
  const XpBurst({super.key, required this.xp, this.animate = true,});

  final int xp;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.flameCoral, Color(0xFFE8733A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        boxShadow: const [
          BoxShadow(
            color: AppColors.flameGlow,
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Text(
        '+$xp XP',
        style: AppTypography.labelLarge.copyWith(
          color: AppColors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    if (!animate) return badge;

    return badge
        .animate()
        .scale(
          begin: const Offset(0.6, 0.6),
          duration: 300.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 200.ms);
  }
}
