import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import 'login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Initialize Roll Call Test Cases', () {
    testWidgets('Valid Roll Call', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);

      final Finder beginRollCall =
          find.byKey(const Key('iniciar_chamada_button'));
      await tester.tap(beginRollCall);
      await tester.pumpAndSettle();

      final Finder dropdownClass = find.byKey(const Key('dropdown-class'));
      await tester.tap(dropdownClass);
      await tester.pumpAndSettle();

      final Finder dropdownSelect =
          find.byKey(const Key('dropdown-select')).at(5);
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

        const String expectedValue = 'PROGRAMAÇÃO ORIENTADA A OBJETOS - A1';

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

      final Finder selectStartClassButton = find.byKey(const Key('select start class button'));
      await tester.tap(selectStartClassButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'), warnIfMissed: false);
      await tester.pumpAndSettle();

      final Finder selectEndClassButton = find.byKey(const Key('select end class button'));
      await tester.tap(selectEndClassButton, warnIfMissed: false);
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
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);

      final Finder beginRollCall =
      find.byKey(const Key('iniciar_chamada_button'));
      await tester.tap(beginRollCall);
      await tester.pumpAndSettle();

      final Finder dropdownClass = find.byKey(const Key('dropdown-class'));
      await tester.tap(dropdownClass);
      await tester.pumpAndSettle();

      final Finder dropdownSelect =
      find.byKey(const Key('dropdown-select')).at(5);
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

        const String expectedValue = 'PROGRAMAÇÃO ORIENTADA A OBJETOS - A1';

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

      final Finder selectStartClassButton = find.byKey(const Key('select start class button'));
      await tester.tap(selectStartClassButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'), warnIfMissed: false);
      await tester.pumpAndSettle();

      final Finder selectEndClassButton = find.byKey(const Key('switch to manual end'));
      await tester.tap(selectEndClassButton);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('start roll call button')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirmar'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(Expanded, 'Chamada'), findsOneWidget);

    });
  });
}
