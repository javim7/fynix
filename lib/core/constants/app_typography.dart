import 'package:flutter/material.dart';
import 'package:fynix/core/constants/app_colors.dart';

/// Fynix typography — Montserrat (headings) + Inter (body/UI)
/// Uses google_fonts under the hood via [AppTheme]; these constants
/// define the base style properties reused throughout the design system.
abstract final class AppTypography {
  static const String _heading = 'Montserrat';
  static const String _body = 'Inter';

  // ─── Display / Hero ─────────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _heading,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -1.0,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _heading,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  // ─── Headings ────────────────────────────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontFamily: _heading,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _heading,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: _heading,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: _heading,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // ─── Body ────────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _body,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _body,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _body,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.midGray,
  );

  // ─── UI Labels ───────────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _body,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _body,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.midGray,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _body,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.midGray,
    letterSpacing: 0.5,
  );

  // ─── Special ─────────────────────────────────────────────────────────────
  /// Large XP / stat numbers — always Gold
  static const TextStyle statDisplay = TextStyle(
    fontFamily: _heading,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );

  static const TextStyle statLarge = TextStyle(
    fontFamily: _heading,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );

  /// Button text
  static const TextStyle button = TextStyle(
    fontFamily: _heading,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  /// Bottom nav labels
  static const TextStyle navLabel = TextStyle(
    fontFamily: _body,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}
