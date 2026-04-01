import 'package:flutter_test/flutter_test.dart';
import 'package:fynix/core/utils/pace_formatter.dart';

void main() {
  group('PaceFormatter — format', () {
    test('330 s/km → "5:30 /km"', () {
      expect(PaceFormatter.format(330), '5:30 /km');
    });

    test('600 s/km → "10:00 /km"', () {
      expect(PaceFormatter.format(600), '10:00 /km');
    });

    test('60 s/km → "1:00 /km"', () {
      expect(PaceFormatter.format(60), '1:00 /km');
    });

    test('61 s/km → "1:01 /km" (seconds padded)', () {
      expect(PaceFormatter.format(61), '1:01 /km');
    });

    test('fractional rounds correctly — 330.4 → 330 → "5:30 /km"', () {
      expect(PaceFormatter.format(330.4), '5:30 /km');
    });

    test('fractional rounds up — 330.6 → 331 → "5:31 /km"', () {
      expect(PaceFormatter.format(330.6), '5:31 /km');
    });
  });

  group('PaceFormatter — formatShort', () {
    test('330 → "5:30" (no unit)', () {
      expect(PaceFormatter.formatShort(330), '5:30');
    });

    test('3600 → "60:00"', () {
      expect(PaceFormatter.formatShort(3600), '60:00');
    });

    test('9 seconds → "0:09" (zero-padded)', () {
      expect(PaceFormatter.formatShort(9), '0:09');
    });
  });

  group('PaceFormatter — formatDuration', () {
    test('3600 s → "1:00:00"', () {
      expect(PaceFormatter.formatDuration(3600), '1:00:00');
    });

    test('90 s → "1:30" (no hours)', () {
      expect(PaceFormatter.formatDuration(90), '1:30');
    });

    test('3661 s → "1:01:01"', () {
      expect(PaceFormatter.formatDuration(3661), '1:01:01');
    });

    test('59 s → "0:59"', () {
      expect(PaceFormatter.formatDuration(59), '0:59');
    });

    test('0 s → "0:00"', () {
      expect(PaceFormatter.formatDuration(0), '0:00');
    });

    test('7200 s → "2:00:00"', () {
      expect(PaceFormatter.formatDuration(7200), '2:00:00');
    });

    test('5400 s (1h 30min) → "1:30:00"', () {
      expect(PaceFormatter.formatDuration(5400), '1:30:00');
    });
  });

  group('PaceFormatter — formatDurationHuman', () {
    test('3600 s → "1h"', () {
      expect(PaceFormatter.formatDurationHuman(3600), '1h');
    });

    test('5400 s → "1h 30m"', () {
      expect(PaceFormatter.formatDurationHuman(5400), '1h 30m');
    });

    test('1800 s → "30m"', () {
      expect(PaceFormatter.formatDurationHuman(1800), '30m');
    });

    test('7200 s → "2h"', () {
      expect(PaceFormatter.formatDurationHuman(7200), '2h');
    });

    test('7260 s → "2h 1m"', () {
      expect(PaceFormatter.formatDurationHuman(7260), '2h 1m');
    });

    test('60 s → "1m"', () {
      expect(PaceFormatter.formatDurationHuman(60), '1m');
    });
  });

  group('PaceFormatter — formatSpeed', () {
    test('10.0 km/h → "10.0 km/h"', () {
      expect(PaceFormatter.formatSpeed(10.0), '10.0 km/h');
    });

    test('12.345 km/h rounds to 1 decimal → "12.3 km/h"', () {
      expect(PaceFormatter.formatSpeed(12.345), '12.3 km/h');
    });

    test('0.0 km/h → "0.0 km/h"', () {
      expect(PaceFormatter.formatSpeed(0.0), '0.0 km/h');
    });
  });
}
