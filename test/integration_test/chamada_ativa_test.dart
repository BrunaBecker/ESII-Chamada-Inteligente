import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/app/core/theme/app_colors.dart';
import 'package:mac_fi/main.dart' as app;

import 'iniciar_chamada_test.dart';
import 'login_test.dart';

Future<void> markAs(
    WidgetTester tester, String newStatus, Finder statusIconFinder) async {
  await tester.tap(statusIconFinder);
  await tester.pumpAndSettle();

  if (newStatus == "present") {
    Finder presentButton = find.text("Presença");
    await tester.tap(presentButton);
    await tester.pumpAndSettle();
  } else if (newStatus == "absent") {
    Finder absentButton = find.text("Falta");
    await tester.tap(absentButton);
    await tester.pumpAndSettle();
  } else {
    Finder justifiedButton = find.text("Falta abonada");
    await tester.tap(justifiedButton);
    await tester.pumpAndSettle();
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Verify proper integration of an active class interactions', () {
    testWidgets('Mark students as present', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder statusIconFinder =
          find.byKey(const Key('student status icon')).first;
      await markAs(tester, "absent", statusIconFinder);

      final Icon statusIcon = tester.widget<Icon>(statusIconFinder);

      expect(statusIcon.icon, equals(Icons.close_outlined));

      await markAs(tester, "present", statusIconFinder);

      final Icon newStatusIcon = tester.widget<Icon>(statusIconFinder);
      expect(newStatusIcon.icon, equals(Icons.check_outlined));
    });

    testWidgets('Check present student icon color',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder popupMenuButtonFinder =
          find.byKey(const Key('student status popup menu button'));
      final Finder iconFinder = find
          .descendant(
            of: popupMenuButtonFinder,
            matching: find.byWidgetPredicate((widget) {
              return widget is Icon &&
                  widget.icon == Icons.check_outlined &&
                  widget.color == AppColors.onSurfaceVariant;
            }),
          )
          .first;

      final Finder checkGreenFinder = find.descendant(
        of: popupMenuButtonFinder,
        matching: find.byWidgetPredicate((widget) {
          return widget is Icon &&
              widget.icon == Icons.check_outlined &&
              widget.color == AppColors.green1;
        }),
      );

      int quantityOfChecksBefore = checkGreenFinder.evaluate().length;

      await markAs(tester, "present", iconFinder);

      int quantityOfChecksAfter = checkGreenFinder.evaluate().length;

      expect(quantityOfChecksAfter, equals(quantityOfChecksBefore + 1));
    });

    testWidgets('Mark students as absent', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder statusIconFinder =
          find.byKey(const Key('student status icon')).first;
      await markAs(tester, "present", statusIconFinder);

      final Icon statusIcon = tester.widget<Icon>(statusIconFinder);

      expect(statusIcon.icon, equals(Icons.check_outlined));

      await markAs(tester, "absent", statusIconFinder);

      final Icon newStatusIcon = tester.widget<Icon>(statusIconFinder);
      expect(newStatusIcon.icon, equals(Icons.close_outlined));
    });

    testWidgets('Check absent student icon color', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder popupMenuButtonFinder =
          find.byKey(const Key('student status popup menu button'));
      final Finder iconFinder = find
          .descendant(
            of: popupMenuButtonFinder,
            matching: find.byWidgetPredicate((widget) {
              return widget is Icon &&
                  widget.icon == Icons.close_outlined &&
                  widget.color == AppColors.onSurfaceVariant;
            }),
          )
          .first;

      final Finder closeRedFinder = find.descendant(
        of: popupMenuButtonFinder,
        matching: find.byWidgetPredicate((widget) {
          return widget is Icon &&
              widget.icon == Icons.close_outlined &&
              widget.color == AppColors.red1;
        }),
      );

      int quantityOfClosesBefore = closeRedFinder.evaluate().length;

      await markAs(tester, "absent", iconFinder);

      int quantityOfClosesAfter = closeRedFinder.evaluate().length;

      expect(quantityOfClosesAfter, equals(quantityOfClosesBefore + 1));
    });

    testWidgets('Mark students as justified', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder statusIconFinder =
          find.byKey(const Key('student status icon')).first;
      await markAs(tester, "present", statusIconFinder);

      final Icon statusIcon = tester.widget<Icon>(statusIconFinder);

      expect(statusIcon.icon, equals(Icons.check_outlined));

      await markAs(tester, "justified", statusIconFinder);

      final Icon newStatusIcon = tester.widget<Icon>(statusIconFinder);
      expect(newStatusIcon.icon, equals(Icons.indeterminate_check_box));
      expect(newStatusIcon.color, equals(AppColors.green1));
    });

    testWidgets('Check call information', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder mapOutlinedFinder = find.byKey(const Key('map outlined icon'));
      await tester.tap(mapOutlinedFinder);
      await tester.pumpAndSettle();

      expect(find.text("Chamada local"), findsOneWidget);
    });

    testWidgets('Check finish roll call', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder closeButton = find.byKey(const Key('close roll call'));
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      Finder confirm = find.text('Confirmar');
      await tester.tap(confirm);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(Expanded, 'Chamada'), findsOneWidget);

    });

    testWidgets('Add student manually', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder addStudentButton = find.byKey(const Key('add student icon'));
      await tester.tap(addStudentButton);
      await tester.pumpAndSettle();

      final Finder nameFinder = find.byKey(const Key('student name add form'));
      await tester.enterText(nameFinder, 'Novo Aluno');
      await tester.pumpAndSettle();

      final Finder regisFinder = find.byKey(const Key('registration name add form'));
      await tester.enterText(regisFinder, '123456711');
      await tester.pumpAndSettle();

      Finder confirm = find.text('Adicionar');
      await tester.tap(confirm);
      await tester.pumpAndSettle();

      expect(find.text('Novo Aluno'), findsOneWidget);

    });

    testWidgets('Check statistics update', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));

      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await loginProfessor(tester);

      await iniciarChamada(tester);

      Finder studentsPresenceStringFinder =
      find.byKey(const Key('number of students answer'));

      final Element selectedElement =
          studentsPresenceStringFinder.evaluate().first;
      final String? stringStudentsStatistics =
          (selectedElement.widget as Text).data;

      String? numberStudents = stringStudentsStatistics?.split(" ")[3];
      int numberOfPresentStudentsAfter = int.parse(numberStudents!) + 1;

      Finder popupMenuButtonFinder =
      find.byKey(const Key('student status popup menu button'));
      final Finder iconFinder = find
          .descendant(
        of: popupMenuButtonFinder,
        matching: find.byWidgetPredicate((widget) {
          return widget is Icon &&
              widget.icon == Icons.indeterminate_check_box &&
              widget.color == AppColors.onSurfaceVariant;
        }),
      )
          .first;

      await markAs(tester, "present", iconFinder);

      final Element newSelectedElement =
          studentsPresenceStringFinder.evaluate().first;
      final String? newStringStudentsStatistics =
          (newSelectedElement.widget as Text).data;

      String? newNumberStudents = newStringStudentsStatistics?.split(" ")[3];
      int newNumberOfPresentStudentsAfter = int.parse(newNumberStudents!);

      expect(newNumberOfPresentStudentsAfter,
          equals(numberOfPresentStudentsAfter));
    });
  });
}
