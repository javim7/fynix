import 'package:flutter/material.dart';

/// Fynix color palette — Phoenix Dark System
/// High-contrast dark-first: navy-black background, golden-orange brand.
abstract final class AppColors {
  // ─── Backgrounds / Surfaces ──────────────────────────────────────────────
  /// Primary background — deep navy-black
  static const Color obsidian = Color(0xFF0B0F1A);

  /// Card / elevated surface background
  static const Color darkEmber = Color(0xFF121826);

  /// Border and divider color
  static const Color ember = Color(0xFF1F2937);

  /// Deepest surface — bottom nav, overlays
  static const Color surface0 = Color(0xFF060A12);

  /// Input field fill — slightly lighter than card
  static const Color surface2 = Color(0xFF1A2234);

  // ─── Brand (Phoenix) ─────────────────────────────────────────────────────
  /// PRIMARY brand — golden orange
  static const Color gold = Color(0xFFF59E0B);

  /// Lighter golden tint — hover states, soft highlights
  static const Color honey = Color(0xFFFCD34D);

  /// Strong accent orange — CTAs, energy moments
  static const Color flameCoral = Color(0xFFF97316);

  // ─── Gamification ────────────────────────────────────────────────────────
  /// XP gains, positive feedback, level bar fill
  static const Color xpGreen = Color(0xFF22C55E);

  /// Level-up flash accent
  static const Color levelAccent = Color(0xFFA3E635);

  /// AI / premium feature accent
  static const Color aiAccent = Color(0xFF7C3AED);

  // ─── Neutral ─────────────────────────────────────────────────────────────
  /// Light mode backgrounds only
  static const Color cream = Color(0xFFFFF8EE);

  /// Primary text on dark backgrounds
  static const Color white = Color(0xFFFFFFFF);

  /// Secondary text, labels, disabled, placeholders
  static const Color midGray = Color(0xFF9CA3AF);

  // ─── Overlay / border tokens ─────────────────────────────────────────────
  /// Hairline border — white at 8% opacity
  static const Color borderHairline = Color(0x14FFFFFF);

  /// Subtle border — white at 15% opacity
  static const Color borderSubtle = Color(0x26FFFFFF);

  // ─── Glow / shadow tokens ────────────────────────────────────────────────
  /// Gold glow for button/card shadows
  static const Color goldGlow = Color(0x59F59E0B);

  /// Flame glow for streak/XP shadows
  static const Color flameGlow = Color(0x4DF97316);

  // ─── Semantic aliases ────────────────────────────────────────────────────
  static const Color primary = gold;
  static const Color secondary = flameCoral;
  static const Color surface = darkEmber;
  static const Color background = obsidian;
  static const Color onBackground = white;
  static const Color onSurface = white;
  static const Color onPrimary = obsidian;
  static const Color disabled = midGray;
  static const Color error = Color(0xFFEF4444);
  static const Color success = xpGreen;
}
