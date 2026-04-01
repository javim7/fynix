import 'package:flutter_test/flutter_test.dart';
import 'package:fynix/core/utils/xp_calculator.dart';

void main() {
  group('XpCalculator — base rates', () {
    test('running: 10 XP per km', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
      );
      expect(result.baseXp, 100);
    });

    test('running: fractional — 3.7 km = 37 XP', () {
      final result = XpCalculator.calculate(
        distanceMeters: 3700,
        durationSeconds: 1200,
        sport: SportType.running,
      );
      expect(result.baseXp, 37);
    });

    test('swimming: 30 XP per km, 0.5 km = 15 XP', () {
      final result = XpCalculator.calculate(
        distanceMeters: 500,
        durationSeconds: 900,
        sport: SportType.swimming,
      );
      expect(result.baseXp, 15);
    });

    test('cycling: 3 XP per km, 12.3 km = 37 XP (rounded)', () {
      final result = XpCalculator.calculate(
        distanceMeters: 12300,
        durationSeconds: 2400,
        sport: SportType.cycling,
      );
      expect(result.baseXp, 37);
    });

    test('walking: 5 XP per km', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 3600,
        sport: SportType.walking,
      );
      expect(result.baseXp, 25);
    });

    test('hiking: 8 XP per km', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 7200,
        sport: SportType.hiking,
      );
      expect(result.baseXp, 80);
    });

    test('strength: 50 XP per hour, 45 min = 38 XP', () {
      final result = XpCalculator.calculate(
        distanceMeters: 0,
        durationSeconds: 2700, // 45 min
        sport: SportType.strength,
      );
      expect(result.baseXp, 38);
    });

    test('yoga: 40 XP per hour, 1h 20min = 53 XP', () {
      final result = XpCalculator.calculate(
        distanceMeters: 0,
        durationSeconds: 4800, // 80 min
        sport: SportType.yoga,
      );
      expect(result.baseXp, 53);
    });

    test('crossfit: 60 XP per hour, 1 hour = 60 XP', () {
      final result = XpCalculator.calculate(
        distanceMeters: 0,
        durationSeconds: 3600,
        sport: SportType.crossfit,
      );
      expect(result.baseXp, 60);
    });

    test('other: 50 XP per hour', () {
      final result = XpCalculator.calculate(
        distanceMeters: 0,
        durationSeconds: 3600,
        sport: SportType.other,
      );
      expect(result.baseXp, 50);
    });
  });

  group('XpCalculator — streak bonuses', () {
    test('no streak bonus below 7 days', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
        currentStreak: 6,
      );
      expect(result.streakBonus, 0);
      expect(result.total, result.baseXp);
    });

    test('7-day streak: +10%', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
        currentStreak: 7,
      );
      expect(result.streakBonus, 10); // 10% of 100
      expect(result.total, 110);
    });

    test('14-day streak: +20%', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
        currentStreak: 14,
      );
      expect(result.streakBonus, 20);
      expect(result.total, 120);
    });

    test('30-day streak: +30%', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
        currentStreak: 30,
      );
      expect(result.streakBonus, 30);
      expect(result.total, 130);
    });

    test('90-day streak: +50%', () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
        currentStreak: 90,
      );
      expect(result.streakBonus, 50);
      expect(result.total, 150);
    });
  });

  group('XpCalculator — PR bonuses', () {
    test('PR bonus +50 for fastest pace', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        isPersonalRecord: true,
      );
      expect(result.prBonus, 50);
    });

    test('new longest distance +30 XP', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        isNewLongestDistance: true,
      );
      expect(result.prBonus, 30);
    });

    test('both PR bonuses stack', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        isPersonalRecord: true,
        isNewLongestDistance: true,
      );
      expect(result.prBonus, 80);
    });
  });

  group('XpCalculator — morning bonus', () {
    test('+5 XP for workout starting at 5:00', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        workoutStartHour: 5,
      );
      expect(result.morningBonus, 5);
    });

    test('+5 XP for workout starting at 6:59', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        workoutStartHour: 6,
      );
      expect(result.morningBonus, 5);
    });

    test('no morning bonus at 7:00', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        workoutStartHour: 7,
      );
      expect(result.morningBonus, 0);
    });

    test('no morning bonus at 4:59', () {
      final result = XpCalculator.calculate(
        distanceMeters: 5000,
        durationSeconds: 1500,
        sport: SportType.running,
        workoutStartHour: 4,
      );
      expect(result.morningBonus, 0);
    });
  });

  group('XpCalculator — level system', () {
    test('level 1 requires 0 XP', () {
      expect(XpCalculator.xpForLevel(1), 0);
    });

    test('level 2 requires 800 XP (400 * 2^1.5 = 1131.37 → floor = 1131)', () {
      // 400 * 2^1.5 = 400 * 2.828... = 1131.37 → floor = 1131
      expect(XpCalculator.xpForLevel(2), 1131);
    });

    test('level 1 from 0 XP', () {
      expect(XpCalculator.levelFromXp(0), 1);
    });

    test('level 1 from 500 XP (below level 2 threshold)', () {
      expect(XpCalculator.levelFromXp(500), 1);
    });

    test('level 2 from threshold XP', () {
      final threshold = XpCalculator.xpForLevel(2);
      expect(XpCalculator.levelFromXp(threshold), 2);
    });

    test('level from XP just below threshold stays at previous level', () {
      final threshold = XpCalculator.xpForLevel(5);
      expect(XpCalculator.levelFromXp(threshold - 1), 4);
    });

    test('level 100 is max', () {
      expect(XpCalculator.levelFromXp(99999999), 100);
    });

    test('xpToNextLevel is 0 at level 100', () {
      expect(XpCalculator.xpToNextLevel(99999999), 0);
    });

    test('levelProgress is between 0 and 1', () {
      final progress = XpCalculator.levelProgress(1000);
      expect(progress, greaterThanOrEqualTo(0.0));
      expect(progress, lessThanOrEqualTo(1.0));
    });
  });

  group('XpCalculator — total calculation', () {
    test('full workout: 10km run, 30-day streak, morning, PR = correct total',
        () {
      final result = XpCalculator.calculate(
        distanceMeters: 10000,
        durationSeconds: 3600,
        sport: SportType.running,
        currentStreak: 30,
        isPersonalRecord: true,
        workoutStartHour: 6,
      );
      // base=100, streak=30 (30%), pr=50, morning=5 → total=185
      expect(result.baseXp, 100);
      expect(result.streakBonus, 30);
      expect(result.prBonus, 50);
      expect(result.morningBonus, 5);
      expect(result.total, 185);
    });
  });
}
