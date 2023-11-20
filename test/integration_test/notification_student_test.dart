import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import '../unit_test/notification_button_test.dart';
import 'login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Notifications Integration Tests', () {
    testWidgets('Mark notification as read', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginAluno(tester);

      await goToNotificationPage(tester);

      final Finder firstNotification =
          find.byKey(const Key('notification list')).first;

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

      IconButton iconButtonAfter =
      tester.widget(iconButtonFinder.first) as IconButton;

      Icon iconAfter = iconButtonAfter.icon as Icon;
      bool isReadIconAfter = iconAfter.icon == Icons.notifications_outlined;

      expect(isReadIconAfter, !isReadIcon);
    });

    testWidgets('Delete notification', (WidgetTester tester) async {
      // Run the app
      // app.main();
      // await tester.pumpAndSettle();
      //
      // await loginProfessor(tester);
      //
      // await goToNotificationPage(tester);
      //
      // final Finder firstNotification =
      //     find.byKey(const Key('notification list')).first;
      //
      // final Finder secondNotification =
      //     find.byKey(const Key('notification list')).at(1);
      //
      // final secondTile = tester.widget<ListTile>(secondNotification);
      // final String originalClass = secondTile.title.toString();
      //
      // final Finder trailingWidgetFinder = find.descendant(
      //   of: firstNotification,
      //   matching: find.byType(PopupMenuButton),
      // );
      //
      // if (tester.any(trailingWidgetFinder)) {
      //   await tester.tap(trailingWidgetFinder);
      //   await tester.pumpAndSettle();
      // }
      //
      // final Finder deleteNotification =
      //     find.byKey(const Key('delete notification'));
      //
      // if (tester.any(deleteNotification)) {
      //   await tester.tap(deleteNotification);
      //   await tester.pumpAndSettle();
      // }
      //
      // final firstTile = tester.widget<ListTile>(firstNotification);
      // final String afterClass = firstTile.title.toString();
      //
      // expect(originalClass, afterClass);
    });

    testWidgets('Return to main page', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginAluno(tester);

      await goToNotificationPage(tester);

      final Finder notificationButton =
      find.byKey(const Key('notification_button_pressed'));

      await tester.tap(notificationButton);
      await tester.pumpAndSettle();

      expect(find.text('Registre sua presença!'), findsOneWidget);
    });
  });
}
