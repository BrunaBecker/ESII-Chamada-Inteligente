import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../integration_test/login_test.dart';
import 'package:mac_fi/main.dart' as app;

Future<void> goToMinhasTurmasPage(WidgetTester tester) async {
  final Finder turmasButton = find.byKey(const Key('turmas_button'));
  await tester.tap(turmasButton);
  await tester.pumpAndSettle();

  expect(find.text('Minhas turmas'), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Minhas turmas page widgets', () {
    testWidgets('Check proper functionality of class drawer',
        (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);
      await goToMinhasTurmasPage(tester);

      final Finder classDrawer = find.byType(DrawerButtonIcon);
      await tester.tap(classDrawer);
      await tester.pumpAndSettle();

      expect(find.text('MAC-FI'), findsOneWidget);

      final Finder firstClassTileDrawer =
          find.byKey(const Key('drawer class tile')).first;
      await tester.tap(firstClassTileDrawer);
      await tester.pumpAndSettle();
    });

    testWidgets('Interact with a class', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);
      await goToMinhasTurmasPage(tester);

      final Finder classTileFinder =
          find.byKey(const Key('list tile class')).at(2);
      String? classTileName =
          ((tester.widget(classTileFinder) as ListTile).subtitle as Text).data;

      List<String>? wordsOfClassName = classTileName?.split(' ');
      List<String>? remainingClassWords =
          wordsOfClassName?.sublist(0, wordsOfClassName.length - 2);
      String? classTitle = remainingClassWords?.join(' ');

      final Finder interactClassButtonFinder =
          find.byKey(const Key('interact class ellipsis button')).at(2);
      await tester.tap(interactClassButtonFinder);
      await tester.pumpAndSettle();

      final Finder interactFinder = find.byKey(const Key('Ver mais button'));
      await tester.tap(interactFinder);
      await tester.pumpAndSettle();

      final Finder classHeader = find.byKey(const Key('class page header'));

      expect(((tester.widget(classHeader) as AppBar).title as Text).data,
          equals(classTitle));
    });
  });
}
