import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import '../integration_test/login_test.dart';

Future<void> goToPreferencesPage(WidgetTester tester) async {
  final Finder notificationButton =
  find.byKey(const Key('preferências_button'));
  await tester.tap(notificationButton);
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('settings_page_header')), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Preferences page unit tests', () {
    testWidgets('Proper functionality of preset switch', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToPreferencesPage(tester);

      final presetSwitchFinder = find.byKey(const Key('preferences preset switch')).at(0);

      expect(presetSwitchFinder, findsOneWidget);
      expect((tester.widget(presetSwitchFinder) as Switch).value, isTrue);

      await tester.tap(presetSwitchFinder);
      await tester.pumpAndSettle();

      expect((tester.widget(presetSwitchFinder) as Switch).value, isFalse);

    });

    testWidgets('Proper functionality of saving location', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToPreferencesPage(tester);

      final presetSwitchFinder = find.byKey(const Key('preferences preset switch')).at(1);

      expect(presetSwitchFinder, findsOneWidget);
      expect((tester.widget(presetSwitchFinder) as Switch).value, isTrue);

      await tester.tap(presetSwitchFinder);
      await tester.pumpAndSettle();

      expect((tester.widget(presetSwitchFinder) as Switch).value, isFalse);

    });


    testWidgets('Proper functionality of silence notifications', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToPreferencesPage(tester);

      final presetSwitchFinder = find.byKey(const Key('preferences preset switch')).at(2);

      expect(presetSwitchFinder, findsOneWidget);
      expect((tester.widget(presetSwitchFinder) as Switch).value, isFalse);

      await tester.tap(presetSwitchFinder);
      await tester.pumpAndSettle();

      expect((tester.widget(presetSwitchFinder) as Switch).value, isTrue);

    });

    testWidgets('My locations option card', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToPreferencesPage(tester);

      final myLocationsFinder = find.byType(ListTile).at(0);

      expect(myLocationsFinder, findsOneWidget);
      await tester.tap(myLocationsFinder);
      await tester.pumpAndSettle();

    });

    testWidgets('Change app theme option card', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToPreferencesPage(tester);

      final themeFinder = find.byType(ListTile).at(1);

      expect(themeFinder, findsOneWidget);
      await tester.tap(themeFinder);
      await tester.pumpAndSettle();

    });

    testWidgets('About application and help card', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToPreferencesPage(tester);

      final helpFinder = find.byType(ListTile).at(2);

      expect(helpFinder, findsOneWidget);
      await tester.tap(helpFinder);
      await tester.pumpAndSettle();

    });
  });
}