import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fynix/core/constants/app_colors.dart';
import 'package:fynix/core/widgets/fynix_button.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('FynixButton — primary variant', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(label: 'Empezar', onPressed: () {})),
      );
      expect(find.text('Empezar'), findsOneWidget);
    });

    testWidgets('renders as ElevatedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(label: 'Empezar', onPressed: () {})),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        _wrap(FynixButton(label: 'Tap me', onPressed: () => pressed = true)),
      );
      await tester.tap(find.byType(ElevatedButton));
      expect(pressed, isTrue);
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        _wrap(const FynixButton(label: 'Disabled', onPressed: null)),
      );
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });

  group('FynixButton — secondary variant', () {
    testWidgets('renders as OutlinedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Secundario',
          onPressed: () {},
          variant: FynixButtonVariant.secondary,
        )),
      );
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Tap',
          onPressed: () => pressed = true,
          variant: FynixButtonVariant.secondary,
        )),
      );
      await tester.tap(find.byType(OutlinedButton));
      expect(pressed, isTrue);
    });
  });

  group('FynixButton — ghost variant', () {
    testWidgets('renders as TextButton', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Ghost',
          onPressed: () {},
          variant: FynixButtonVariant.ghost,
        )),
      );
      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('FynixButton — loading state', () {
    testWidgets('shows CircularProgressIndicator when isLoading', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Loading',
          onPressed: () {},
          isLoading: true,
        )),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('button is disabled while loading', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Loading',
          onPressed: () {},
          isLoading: true,
        )),
      );
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });

  group('FynixButton — icon', () {
    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Con icono',
          onPressed: () {},
          icon: Icons.check_circle_rounded,
        )),
      );
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
      expect(find.text('Con icono'), findsOneWidget);
    });

    testWidgets('no icon widget when icon is null', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(label: 'Sin icono', onPressed: () {})),
      );
      expect(find.byType(Icon), findsNothing);
    });
  });

  group('FynixButton — full width', () {
    testWidgets('isFullWidth=true uses infinite width constraint', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(label: 'Full', onPressed: () {})),
      );
      // Widget should render without overflow errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('isFullWidth=false does not expand', (tester) async {
      await tester.pumpWidget(
        _wrap(FynixButton(
          label: 'Compact',
          onPressed: () {},
          isFullWidth: false,
        )),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
