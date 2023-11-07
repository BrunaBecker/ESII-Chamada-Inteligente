import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import 'login_test.dart';
import '../unit/notification_button_test.dart';

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

      final Widget notificationWidget = tester.widget(firstNotification);


      if (notificationWidget is ListTile) {
        final ListTile listTile = notificationWidget;

        final Widget? leadingWidget = listTile.leading;
        if (leadingWidget is IconButton) {
          final IconButton iconButton = leadingWidget;
          final Icon icon = iconButton.icon as Icon;
          print('IconButton Icon: ${icon.icon}');
        }

        final Widget? trailingWidget = listTile.trailing;
        if (trailingWidget is PopupMenuButton) {
          final Finder popupMenuButtonFinder = find.byWidget(trailingWidget);
          await tester.tap(popupMenuButtonFinder);
          await tester.pumpAndSettle(); // Allow time for the menu to appear

          // Find the first PopupMenuItem within the PopupMenuButton
          final Finder firstPopupMenuItemFinder = find.descendant(
            of: popupMenuButtonFinder,
            matching: find.byType(PopupMenuItem),
          );

          // Tap the first PopupMenuItem
          await tester.tap(firstPopupMenuItemFinder);
          await tester.pumpAndSettle(); // Allow time for the menu to close and updates to occur
        }

      }

      // // Find the IconButton inside the first notification
      // final Finder iconButtonFinder = find.descendant(
      //   of: firstNotification,
      //   matching: find.byWidgetPredicate((widget) {
      //     return widget is IconButton;
      //   }),
      // );
      //
      // final Finder popupMenuItemFinder = find.descendant(
      //   of: firstNotification,
      //   matching: find.byType(PopupMenuButton),
      // );
      //
      //
      // // Check the icon inside the IconButton to determine if it's read or not
      // final IconButton iconButton =
      //     tester.widget(iconButtonFinder.first) as IconButton;
      // final icon = iconButton.icon;
      //
      // if (icon == Icon(Icons.notifications_outlined)) {
      //   print('The first notification is read.');
      // } else {
      //   print('The first notification is unread.');
      // }
      //
      // await tester.tap(popupMenuItemFinder.first);
      // await tester.pumpAndSettle();
      //
      // // if (icon == Icon(Icons.notifications_outlined)) {
      // //   print('The first notification is read.');
      // // } else {
      // //   print('The first notification is unread.');
      // // }
    });
  });
}
