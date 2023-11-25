import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;

import '../unit_test/iniciar_chamada_test.dart';
import 'login_test.dart';

Future<void> iniciarChamada(WidgetTester tester) async {
  await goToBeginRollCallPage(tester);

  final Finder presetSwitch = find.byKey(const Key('preset activate switch'));
  await tester.tap(presetSwitch);
  await tester.pumpAndSettle();

  final Finder startRollCallFinger =
      find.byKey(const Key('start roll call button'));
  await tester.tap(startRollCallFinger);
  await tester.pumpAndSettle();

  await tester.tap(find.text('Confirmar'));
  await tester.pumpAndSettle();

  expect(find.widgetWithText(Expanded, 'Chamada'), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Initialize Roll Call Test Cases', () {
    testWidgets('Valid Roll Call', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await goToBeginRollCallPage(tester);

      final Finder dropdownClass = find.byKey(const Key('dropdown-class'));
      await tester.tap(dropdownClass);
      await tester.pumpAndSettle();

      final Finder dropdownSelect =
          find.byKey(const Key('dropdown-select')).first;
      await tester.tap(dropdownSelect);
      await tester.pumpAndSettle();

      final Finder selectedText = find.descendant(
        of: dropdownClass,
        matching: find.byType(Text),
      );

      if (selectedText.evaluate().isNotEmpty) {
        final Element selectedElement = selectedText.evaluate().first;
        final String? selectedValue =
            (selectedElement.widget as Text).data; // Extract text content

        const String expectedValue = 'classroom 1';

        expect(selectedValue, equals(expectedValue),
            reason: 'Selected value does not match expected value');
      } else {
        fail('No selected value found.');
      }

      final Finder dateEditButton = find.byKey(const Key('date-edit-button'));
      await tester.tap(dateEditButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final Finder selectStartClassButton =
          find.byKey(const Key('select start class button'));
      await tester.tap(selectStartClassButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'), warnIfMissed: false);
      await tester.pumpAndSettle();

      final Finder selectEndClassButton =
          find.byKey(const Key('select end class button'));
      await tester.tap(selectEndClassButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('start roll call button')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirmar'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(Expanded, 'Chamada'), findsOneWidget);
    });

    testWidgets('Valid Roll Call Manual End', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await goToBeginRollCallPage(tester);

      final Finder dropdownClass = find.byKey(const Key('dropdown-class'));
      await tester.tap(dropdownClass);
      await tester.pumpAndSettle();

      final Finder dropdownSelect =
          find.byKey(const Key('dropdown-select')).first;
      await tester.tap(dropdownSelect);
      await tester.pumpAndSettle();

      final Finder selectedText = find.descendant(
        of: dropdownClass,
        matching: find.byType(Text),
      );

      if (selectedText.evaluate().isNotEmpty) {
        final Element selectedElement = selectedText.evaluate().first;
        final String? selectedValue =
            (selectedElement.widget as Text).data; // Extract text content

        const String expectedValue = 'classroom 1';

        expect(selectedValue, equals(expectedValue),
            reason: 'Selected value does not match expected value');
      } else {
        fail('No selected value found.');
      }

      final Finder dateEditButton = find.byKey(const Key('date-edit-button'));
      await tester.tap(dateEditButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final Finder selectStartClassButton =
          find.byKey(const Key('select start class button'));
      await tester.tap(selectStartClassButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'), warnIfMissed: false);
      await tester.pumpAndSettle();

      final Finder selectEndClassButton =
          find.byKey(const Key('End call manually switch'));
      await tester.tap(selectEndClassButton);
      await tester.pumpAndSettle();

      final Finder startRollCallFinger =
          find.byKey(const Key('start roll call button'));
      await tester.tap(startRollCallFinger);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirmar'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(Expanded, 'Chamada'), findsOneWidget);
    });

    testWidgets('Use preset call', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await goToBeginRollCallPage(tester);

      final Finder dropdownClass = find.byKey(const Key('dropdown-class'));
      await tester.tap(dropdownClass);
      await tester.pumpAndSettle();

      final Finder dropdownSelect =
          find.byKey(const Key('dropdown-select')).first;
      await tester.tap(dropdownSelect);
      await tester.pumpAndSettle();

      final Finder selectedText = find.descendant(
        of: dropdownClass,
        matching: find.byType(Text),
      );

      if (selectedText.evaluate().isNotEmpty) {
        final Element selectedElement = selectedText.evaluate().first;
        final String? selectedValue =
            (selectedElement.widget as Text).data; // Extract text content

        const String expectedValue = 'classroom 1';

        expect(selectedValue, equals(expectedValue),
            reason: 'Selected value does not match expected value');
      } else {
        fail('No selected value found.');
      }

      final Finder presetSwitch =
          find.byKey(const Key('preset activate switch'));
      await tester.tap(presetSwitch);
      await tester.pumpAndSettle();

      final Finder startRollCallFinger =
          find.byKey(const Key('start roll call button'));
      await tester.tap(startRollCallFinger);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirmar'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(Expanded, 'Chamada'), findsOneWidget);
    });

    testWidgets('Mandatory fields: Automatic end', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await goToBeginRollCallPage(tester);

      await tester.tap(find.byKey(const Key('start roll call button')));
      await tester.pumpAndSettle();

      expect(find.text('O campo é obrigatório'), findsNWidgets(3));
    });

    testWidgets('Mandatory fields: Manual end', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await goToBeginRollCallPage(tester);

      await tester.tap(find.byKey(const Key('start roll call button')));
      await tester.pumpAndSettle();

      final Finder selectEndClassButton =
          find.byKey(const Key('End call manually switch'));
      await tester.tap(selectEndClassButton);
      await tester.pumpAndSettle();

      expect(find.text('O campo é obrigatório'), findsNWidgets(2));
    });
  });
}
