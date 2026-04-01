import 'dart:math' as math;

/// Sport types matching the database enum.
enum SportType {
  running,
  cycling,
  swimming,
  walking,
  hiking,
  strength,
  yoga,
  crossfit,
  triathlon,
  other,
}

/// XP breakdown returned by [XpCalculator.calculate].
class XpBreakdown {
  const XpBreakdown({
    required this.baseXp,
    required this.streakBonus,
    required this.prBonus,
    required this.morningBonus,
    required this.total,
    required this.ratePerKm,
    required this.distanceKm,
    required this.sport,
  });

  final int baseXp;
  final int streakBonus;
  final int prBonus;
  final int morningBonus;
  final int total;

  /// Null for duration-based sports.
  final double? ratePerKm;
  final double distanceKm;
  final SportType sport;

  Map<String, dynamic> toJson() => {
        'base_xp': baseXp,
        'streak_bonus': streakBonus,
        'pr_bonus': prBonus,
        'morning_bonus': morningBonus,
        'total': total,
        if (ratePerKm != null) 'rate_per_km': ratePerKm,
        'distance_km': distanceKm,
        'sport': sport.name,
      };
}

/// Client-side XP estimator.
///
/// **This is for display/preview only.**
/// The server-side Edge Function (`xp-calculator`) is always the source of truth.
abstract final class XpCalculator {
  // ─── Base rates ─────────────────────────────────────────────────────────
  /// XP per km for distance-based sports.
  static const Map<SportType, double> _ratePerKm = {
    SportType.running: 10,
    SportType.swimming: 30,
    SportType.cycling: 3,
    SportType.walking: 5,
    SportType.hiking: 8,
  };

  /// XP per hour for duration-based sports.
  static const Map<SportType, double> _ratePerHour = {
    SportType.strength: 50,
    SportType.yoga: 40,
    SportType.crossfit: 60,
    SportType.other: 50,
  };

  // ─── Main calculation ────────────────────────────────────────────────────

  /// Estimates XP for a workout.
  ///
  /// [distanceMeters] — total workout distance in meters (0 for duration-based sports).
  /// [durationSeconds] — total workout duration in seconds.
  /// [sport] — the sport type.
  /// [currentStreak] — user's current streak in days (for streak bonus).
  /// [isPersonalRecord] — whether this workout set a new best pace.
  /// [isNewLongestDistance] — whether this is the user's longest distance for the sport.
  /// [workoutStartHour] — local hour (0–23) when the workout started (for morning bonus).
  static XpBreakdown calculate({
    required double distanceMeters,
    required int durationSeconds,
    required SportType sport,
    int currentStreak = 0,
    bool isPersonalRecord = false,
    bool isNewLongestDistance = false,
    int? workoutStartHour,
  }) {
    final distanceKm = distanceMeters / 1000.0;
    final durationHours = durationSeconds / 3600.0;

    // ── Base XP ─────────────────────────────────────────────────────────
    final int baseXp;
    final double? ratePerKm;

    if (_ratePerKm.containsKey(sport)) {
      final rate = _ratePerKm[sport]!;
      ratePerKm = rate;
      baseXp = (distanceKm * rate).round();
    } else if (_ratePerHour.containsKey(sport)) {
      ratePerKm = null;
      baseXp = (durationHours * _ratePerHour[sport]!).round();
    } else {
      // Fallback: triathlon — treat as sum; for display just use duration
      ratePerKm = null;
      baseXp = (durationHours * 50).round();
    }

    // ── Streak bonus ─────────────────────────────────────────────────────
    final streakMultiplier = _streakMultiplier(currentStreak);
    final int streakBonus = (baseXp * streakMultiplier).round();

    // ── PR bonuses ───────────────────────────────────────────────────────
    final int prBonus =
        (isPersonalRecord ? 50 : 0) + (isNewLongestDistance ? 30 : 0);

    // ── Early morning bonus (05:00–07:00 local) ──────────────────────────
    final int morningBonus =
        (workoutStartHour != null && workoutStartHour >= 5 && workoutStartHour < 7)
            ? 5
            : 0;

    final int total = baseXp + streakBonus + prBonus + morningBonus;

    return XpBreakdown(
      baseXp: baseXp,
      streakBonus: streakBonus,
      prBonus: prBonus,
      morningBonus: morningBonus,
      total: total,
      ratePerKm: ratePerKm,
      distanceKm: distanceKm,
      sport: sport,
    );
  }

  // ─── Streak bonus multiplier ─────────────────────────────────────────────
  static double _streakMultiplier(int streakDays) {
    if (streakDays >= 90) return 0.50;
    if (streakDays >= 30) return 0.30;
    if (streakDays >= 14) return 0.20;
    if (streakDays >= 7) return 0.10;
    return 0.0;
  }

  // ─── Level calculation ───────────────────────────────────────────────────

  /// Returns the cumulative XP required to reach [level].
  /// Level 1 = 0 XP. Level N (N >= 2) = floor(400 * N^1.5).
  static int xpForLevel(int level) {
    if (level <= 1) return 0;
    return (400 * math.pow(level, 1.5)).floor();
  }

  /// Returns the level for a given [totalXp].
  static int levelFromXp(int totalXp) {
    if (totalXp <= 0) return 1;
    // Binary search between 1–100
    int low = 1;
    int high = 100;
    while (low < high) {
      final mid = (low + high + 1) ~/ 2;
      if (xpForLevel(mid) <= totalXp) {
        low = mid;
      } else {
        high = mid - 1;
      }
    }
    return low;
  }

  /// XP progress within the current level.
  static int xpIntoCurrentLevel(int totalXp) {
    final level = levelFromXp(totalXp);
    return totalXp - xpForLevel(level);
  }

  /// XP needed to reach the next level from current total.
  static int xpToNextLevel(int totalXp) {
    final level = levelFromXp(totalXp);
    if (level >= 100) return 0;
    return xpForLevel(level + 1) - totalXp;
  }

  /// Progress fraction (0.0–1.0) within the current level.
  static double levelProgress(int totalXp) {
    final level = levelFromXp(totalXp);
    if (level >= 100) return 1.0;
    final start = xpForLevel(level);
    final end = xpForLevel(level + 1);
    final span = end - start;
    if (span <= 0) return 1.0;
    return (totalXp - start) / span;
  }
}
