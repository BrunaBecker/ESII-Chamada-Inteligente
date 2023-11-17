import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:mac_fi/main.dart' as app;
import '../integration_test/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Check Nav Bottom Bar Buttons', () {
    testWidgets('Home Navigation', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      final Finder navHomeButton = find.byKey(const Key('início_button'));
      await tester.tap(navHomeButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('iniciar_chamada_button')), findsOneWidget);
    });

    testWidgets('Class Navigation', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      final Finder navClassButton = find.byKey(const Key('turmas_button'));
      await tester.tap(navClassButton);
      await tester.pumpAndSettle();

      final Finder classHeader = find.byKey(const Key('class_page_header'));

      final Finder selectedText = find.descendant(
        of: classHeader,
        matching: find.byType(Text),
      );

      if (selectedText.evaluate().isNotEmpty) {
        final Element selectedElement = selectedText.evaluate().first;
        final String? selectedValue = (selectedElement.widget as Text).data;

        const String expectedValue = 'Minhas turmas';

        expect(selectedValue, equals(expectedValue),
            reason: 'Selected value does not match expected value');
      } else {
        fail('No selected value found.');
      }
    });

    testWidgets('Calendar Navigation', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      final Finder navCalendarButton =
          find.byKey(const Key('calendário_button'));
      await tester.tap(navCalendarButton);
      await tester.pumpAndSettle();

      const locale = 'en_US';
      final dateFormat = DateFormat.yMMMM(locale);

      final now = DateTime.now();

      final formattedDate = dateFormat.format(now);

      final textFinder = find.text(formattedDate);

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Settings Navigation', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      final Finder navSettingsButton =
          find.byKey(const Key('preferências_button'));
      await tester.tap(navSettingsButton);
      await tester.pumpAndSettle();

      final Finder classHeader = find.byKey(const Key('settings_page_header'));

      final Finder selectedText = find.descendant(
        of: classHeader,
        matching: find.byType(Text),
      );

      if (selectedText.evaluate().isNotEmpty) {
        final Element selectedElement = selectedText.evaluate().first;
        final String? selectedValue = (selectedElement.widget as Text).data;

        const String expectedValue = 'Preferências';

        expect(selectedValue, equals(expectedValue),
            reason: 'Selected value does not match expected value');
      } else {
        fail('No selected value found.');
      }
    });
  });
}
