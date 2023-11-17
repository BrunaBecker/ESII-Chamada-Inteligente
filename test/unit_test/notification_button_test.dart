import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import '../integration_test/login_test.dart';

Future<void> goToNotificationPage(WidgetTester tester) async {
  final Finder notificationButton =
      find.byKey(const Key('notification_button'));
  await tester.tap(notificationButton);
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('notification_button_pressed')), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Validates notification button', () {
    testWidgets('Go to Notification page', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      final Finder notificationButton =
          find.byKey(const Key('notification_button'));
      await tester.tap(notificationButton);
      await tester.pumpAndSettle();

      expect(
          find.byKey(const Key('notification_button_pressed')), findsOneWidget);
    });

    testWidgets('Back from Notification page', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      final Finder notificationButton =
          find.byKey(const Key('notification_button'));
      await tester.tap(notificationButton);
      await tester.pumpAndSettle();

      final Finder backNotificationButton =
          find.byKey(const Key('notification_button_pressed'));
      await tester.tap(backNotificationButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('notification_button')), findsOneWidget);
    });
  });
}
