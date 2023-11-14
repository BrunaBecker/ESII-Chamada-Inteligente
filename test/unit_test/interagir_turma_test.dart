import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../integration_test/login_test.dart';
import 'minhas_turmas_test.dart';

Future<void> goToClassPage(WidgetTester tester) async {
  final Finder interactClassButtonFinder =
      find.byKey(const Key('interact class ellipsis button')).at(2);
  await tester.tap(interactClassButtonFinder);
  await tester.pumpAndSettle();

  final Finder interactFinder = find.byKey(const Key('Ver mais button'));
  await tester.tap(interactFinder);
  await tester.pumpAndSettle();

  expect(find.text('Meus alunos'), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Interact with a class page', () {
    testWidgets('Filter roll calls by date', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToMinhasTurmasPage(tester);
      await goToClassPage(tester);

      final Finder filterButtonFinder =
          find.byKey(const Key('filter by date button'));
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Select range'), findsOneWidget);

      // TODO: Check in the future to select a previous month so it doesn't break in the case that the current day is before one of the following:

      // await tester.tap(find.text('8'));
      // await tester.pumpAndSettle();
      //
      // await tester.tap(find.text('12'));
      // await tester.pumpAndSettle();
    });

    testWidgets('Check roll calls button', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToMinhasTurmasPage(tester);
      await goToClassPage(tester);

      await tester.tap(find.text('Meus alunos'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chamadas'));
      await tester.pumpAndSettle();

      expect(find.text('Filtrar por data'), findsOneWidget);
    });

    testWidgets('Check my students button', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToMinhasTurmasPage(tester);
      await goToClassPage(tester);

      await tester.tap(find.text('Meus alunos'));
      await tester.pumpAndSettle();

      expect(find.text('Lista de Reprovados'), findsOneWidget);
    });

    testWidgets('Check statistics button', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToMinhasTurmasPage(tester);
      await goToClassPage(tester);

      await tester.tap(find.text('Estatísticas'));
      await tester.pumpAndSettle();

      expect(find.byType(SfCartesianChart), findsOneWidget);
    });

    testWidgets('Check edit roll call button', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToMinhasTurmasPage(tester);
      await goToClassPage(tester);

      final Finder editFinder =
          find.byKey(const Key('edit roll call button')).at(2);
      await tester.tap(editFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('frequency richtext')), findsOneWidget);
    });

    testWidgets('Check student information button',
        (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToMinhasTurmasPage(tester);
      await goToClassPage(tester);

      await tester.tap(find.text('Meus alunos'));
      await tester.pumpAndSettle();

      await tester
          .tap(find.byKey(const Key('go to student information button')).at(4));
      await tester.pumpAndSettle();

      expect(find.text('Presença'), findsOneWidget);
    });
  });
}
