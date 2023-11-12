import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../integration_test/login_test.dart';
import 'package:mac_fi/main.dart' as app;
import 'package:intl/intl.dart';

Future<void> goToBeginRollCallPage(WidgetTester tester) async {
  final Finder beginRollCall = find.byKey(const Key('iniciar_chamada_button'));
  await tester.tap(beginRollCall);
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('dropdown-class')), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Begin roll call unit tests', () {
    testWidgets('Select class dropdown', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      expect(find.byKey(const Key('dropdown-class')), findsOneWidget);

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
    });

    testWidgets('Date picker', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final dateFormFinder = find.byKey(const Key('date-form'));

      expect(dateFormFinder, findsOneWidget);

      expect(
          (tester.widget(dateFormFinder) as TextFormField).controller?.text,
          equals(
              (tester.widget(dateFormFinder) as TextFormField).initialValue));

      final Finder dateEditButton = find.byKey(const Key('date-edit-button'));
      await tester.tap(dateEditButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      expect((tester.widget(dateFormFinder) as TextFormField).controller?.text,
          equals(currentDate));
    });

    testWidgets('Toggle switch updates state correctly',
        (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final toggleFinder = find.byKey(const Key('End call manually switch'));

      expect(toggleFinder, findsOneWidget);
      expect((tester.widget(toggleFinder) as Switch).value, isFalse);

      await tester.tap(toggleFinder);
      await tester.pumpAndSettle();

      expect((tester.widget(toggleFinder) as Switch).value, isTrue);
    });

    testWidgets('Start time picker', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final Finder startFormFinder = find.byKey(const Key('hour start form'));

      expect(startFormFinder, findsOneWidget);

      expect(
          (tester.widget(startFormFinder) as TextFormField).controller?.text,
          equals(
              (tester.widget(startFormFinder) as TextFormField).initialValue));

      final startTimeFinder =
          find.byKey(const Key('select start class button'));
      await tester.tap(startTimeFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      String currentHour = DateFormat('HH:mm').format(DateTime.now());

      expect((tester.widget(startFormFinder) as TextFormField).controller?.text,
          equals(currentHour));
    });

    // TODO: broken
    testWidgets('End time picker', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final Finder endFormFinder = find.byKey(const Key('hour end form'));

      expect(endFormFinder, findsOneWidget);

      expect((tester.widget(endFormFinder) as TextFormField).controller?.text,
          equals((tester.widget(endFormFinder) as TextFormField).initialValue));

      // final endTimeFinder = find.byKey(const Key('select end class button'));
      // await tester.tap(endTimeFinder);
      // await tester.pumpAndSettle();
      //
      // await tester.tap(find.text('OK'));
      // await tester.pumpAndSettle();
      //
      // String currentHour = DateFormat('HH:mm').format(DateTime.now());
      //
      // expect((tester.widget(endFormFinder) as TextFormField).controller?.text, equals(currentHour));
    });
    // TODO: broken
    testWidgets('Toggle preset check state correctly',
        (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final checkFinder = find.byKey(const Key('preset check'));

      expect(checkFinder, findsOneWidget);
      expect((tester.widget(checkFinder) as Checkbox).value, isFalse);

      // await tester.tap(checkFinder);
      // await tester.pumpAndSettle();
      //
      // expect((tester.widget(checkFinder) as Switch).value, isTrue);
    });

    testWidgets('Toggle switch preset state correctly',
        (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final toggleFinder = find.byKey(const Key('preset activate switch'));

      expect(toggleFinder, findsOneWidget);
      expect((tester.widget(toggleFinder) as Switch).value, isFalse);

      await tester.tap(toggleFinder);
      await tester.pumpAndSettle();

      expect((tester.widget(toggleFinder) as Switch).value, isTrue);

      String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      final dateFormFinder = find.byKey(const Key('date-form'));
      expect((tester.widget(dateFormFinder) as TextFormField).controller?.text,
          equals(currentDate));

      final Finder startFormFinder = find.byKey(const Key('hour start form'));
      expect((tester.widget(startFormFinder) as TextFormField).controller?.text,
          equals('09:00'));

      final Finder endFormFinder = find.byKey(const Key('hour end form'));
      expect((tester.widget(endFormFinder) as TextFormField).controller?.text,
          equals('11:00'));
    });

    // TODO: broken
    testWidgets('Start call correctly', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToBeginRollCallPage(tester);

      final toggleFinder = find.byKey(const Key('preset activate switch'));
      await tester.tap(toggleFinder);
      await tester.pumpAndSettle();

      // await tester.tap(find.byKey(const Key('start roll call button')));
      // await tester.pumpAndSettle();
      //
      // await tester.tap(find.text('Confirmar'));
      // await tester.pumpAndSettle();
      //
      // expect(find.byKey(const Key('live icon')), findsOneWidget);
    });
  });
}
