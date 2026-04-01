import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fynix/core/widgets/xp_bar.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('XpBar — rendering', () {
    testWidgets('renders level label', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 5,
          progress: 0.6,
          currentXp: 600,
          xpToNext: 400,
          animate: false,
        )),
      );
      expect(find.text('Nivel 5'), findsOneWidget);
    });

    testWidgets('renders xpToNext label', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 5,
          progress: 0.6,
          currentXp: 600,
          xpToNext: 400,
          animate: false,
        )),
      );
      expect(find.text('+400 XP para nivel 6'), findsOneWidget);
    });

    testWidgets('hides labels when showLabels=false', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 5,
          progress: 0.6,
          currentXp: 600,
          xpToNext: 400,
          showLabels: false,
          animate: false,
        )),
      );
      expect(find.text('Nivel 5'), findsNothing);
    });

    testWidgets('renders without overflow errors', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 1,
          progress: 0.0,
          currentXp: 0,
          xpToNext: 1131,
          animate: false,
        )),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('full progress bar (1.0) renders without error', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 99,
          progress: 1.0,
          currentXp: 1000,
          xpToNext: 0,
          animate: false,
        )),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('clamps progress above 1.0 without error', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 10,
          progress: 1.5, // should be clamped to 1.0
          currentXp: 1000,
          xpToNext: 0,
          animate: false,
        )),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('zero progress renders without error', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBar(
          level: 1,
          progress: 0.0,
          currentXp: 0,
          xpToNext: 1131,
          animate: false,
        )),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('XpBurst — rendering', () {
    testWidgets('displays XP value', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBurst(xp: 37, animate: false)),
      );
      expect(find.text('+37 XP'), findsOneWidget);
    });

    testWidgets('displays large XP value', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBurst(xp: 185, animate: false)),
      );
      expect(find.text('+185 XP'), findsOneWidget);
    });

    testWidgets('renders without overflow errors', (tester) async {
      await tester.pumpWidget(
        _wrap(const XpBurst(xp: 50, animate: false)),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
