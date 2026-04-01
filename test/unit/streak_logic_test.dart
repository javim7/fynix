import 'package:flutter_test/flutter_test.dart';
import 'package:fynix/core/utils/date_helpers.dart';

void main() {
  group('DateHelpers — isToday', () {
    test('now is today', () {
      expect(DateHelpers.isToday(DateTime.now()), isTrue);
    });

    test('yesterday is not today', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateHelpers.isToday(yesterday), isFalse);
    });

    test('tomorrow is not today', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(DateHelpers.isToday(tomorrow), isFalse);
    });
  });

  group('DateHelpers — isYesterday', () {
    test('yesterday is yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateHelpers.isYesterday(yesterday), isTrue);
    });

    test('today is not yesterday', () {
      expect(DateHelpers.isYesterday(DateTime.now()), isFalse);
    });

    test('two days ago is not yesterday', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      expect(DateHelpers.isYesterday(twoDaysAgo), isFalse);
    });
  });

  group('DateHelpers — startOfDay', () {
    test('startOfDay zeroes out time components', () {
      final date = DateTime(2026, 3, 26, 14, 35, 22);
      final start = DateHelpers.startOfDay(date);
      expect(start.hour, 0);
      expect(start.minute, 0);
      expect(start.second, 0);
      expect(start.day, 26);
      expect(start.month, 3);
      expect(start.year, 2026);
    });
  });

  group('DateHelpers — daysBetween', () {
    test('same day → 0 days', () {
      final date = DateTime(2026, 3, 26);
      expect(DateHelpers.daysBetween(date, date), 0);
    });

    test('consecutive days → 1 day', () {
      final d1 = DateTime(2026, 3, 26);
      final d2 = DateTime(2026, 3, 27);
      expect(DateHelpers.daysBetween(d1, d2), 1);
    });

    test('reversed order returns absolute value', () {
      final d1 = DateTime(2026, 3, 26);
      final d2 = DateTime(2026, 3, 27);
      expect(DateHelpers.daysBetween(d2, d1), 1);
    });

    test('7 days apart', () {
      final d1 = DateTime(2026, 3, 20);
      final d2 = DateTime(2026, 3, 27);
      expect(DateHelpers.daysBetween(d1, d2), 7);
    });

    test('ignores time component — same calendar day = 0', () {
      final d1 = DateTime(2026, 3, 26, 0, 0);
      final d2 = DateTime(2026, 3, 26, 23, 59);
      expect(DateHelpers.daysBetween(d1, d2), 0);
    });
  });

  group('DateHelpers — isStreakAlive', () {
    test('null last activity → streak not alive', () {
      expect(DateHelpers.isStreakAlive(null), isFalse);
    });

    test('last activity today → streak alive', () {
      expect(DateHelpers.isStreakAlive(DateTime.now()), isTrue);
    });

    test('last activity yesterday → streak alive', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateHelpers.isStreakAlive(yesterday), isTrue);
    });

    test('last activity 2 days ago → streak dead', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      expect(DateHelpers.isStreakAlive(twoDaysAgo), isFalse);
    });

    test('last activity 7 days ago → streak dead', () {
      final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      expect(DateHelpers.isStreakAlive(sevenDaysAgo), isFalse);
    });
  });

  group('DateHelpers — formatDate', () {
    test('formats date correctly in Spanish', () {
      final date = DateTime(2026, 3, 26);
      expect(DateHelpers.formatDate(date), '26 Mar 2026');
    });

    test('January is Ene', () {
      expect(DateHelpers.formatDate(DateTime(2026, 1, 1)), '1 Ene 2026');
    });

    test('December is Dic', () {
      expect(DateHelpers.formatDate(DateTime(2026, 12, 31)), '31 Dic 2026');
    });
  });

  group('DateHelpers — formatRelative', () {
    test('today returns Hoy', () {
      expect(DateHelpers.formatRelative(DateTime.now()), 'Hoy');
    });

    test('yesterday returns Ayer', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateHelpers.formatRelative(yesterday), 'Ayer');
    });

    test('older date returns formatted string', () {
      final date = DateTime(2026, 1, 15);
      expect(DateHelpers.formatRelative(date), '15 Ene 2026');
    });
  });

  group('DateHelpers — weekStart', () {
    test('Monday returns itself', () {
      // 2026-03-23 is a Monday
      final monday = DateTime(2026, 3, 23);
      expect(DateHelpers.weekStart(monday), DateHelpers.startOfDay(monday));
    });

    test('Sunday returns previous Monday', () {
      // 2026-03-29 is a Sunday → week start = 2026-03-23
      final sunday = DateTime(2026, 3, 29);
      final expectedMonday = DateTime(2026, 3, 23);
      expect(DateHelpers.weekStart(sunday), expectedMonday);
    });

    test('Wednesday returns Monday of same week', () {
      // 2026-03-25 is a Wednesday → week start = 2026-03-23
      final wednesday = DateTime(2026, 3, 25);
      final expectedMonday = DateTime(2026, 3, 23);
      expect(DateHelpers.weekStart(wednesday), expectedMonday);
    });
  });
}
