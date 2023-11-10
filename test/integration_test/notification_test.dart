import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import '../unit_test/notification_button_test.dart';
import 'login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Initialize Roll Call Test Cases', () {
    testWidgets('Valid Roll Call', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);

      await goToNotificationPage(tester);

      final Finder firstNotification =
          find.byKey(const Key('notification list')).first;


      final Finder trailingWidgetFinder = find.descendant(
        of: firstNotification,
        matching: find.byType(PopupMenuButton),
      );

      if (tester.any(trailingWidgetFinder)) {
        await tester.tap(trailingWidgetFinder);
        await tester.pumpAndSettle();
      }

      final Finder markAsReadItem = find.byKey(const Key('mark as read'));

      if (tester.any(markAsReadItem)) {
        await tester.tap(markAsReadItem);
        await tester.pumpAndSettle();
      }

      // Check the icon inside the IconButton to determine if it's read or not
      final Finder iconButtonFinder = find.descendant(
        of: firstNotification,
        matching: find.byWidgetPredicate((widget) {
          return widget is IconButton;
        }),
      );

      IconButton iconButton =
      tester.widget(iconButtonFinder.first) as IconButton;

      Icon icon = iconButton.icon as Icon;
      bool isReadIcon = icon.icon == Icons.notifications_outlined;

      expect(isReadIcon, isTrue,
          reason: 'Notification is not read after marking as read.');
    });
  });
}
