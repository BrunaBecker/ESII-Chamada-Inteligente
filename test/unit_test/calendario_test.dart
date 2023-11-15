import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../integration_test/login_test.dart';
import 'package:mac_fi/main.dart' as app;

Future<void> goToCalendarPage(WidgetTester tester) async {
  final Finder calendarButton = find.byKey(const Key('calendário_button'));
  await tester.tap(calendarButton);
  await tester.pumpAndSettle();

  expect(find.text('November 2023'), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // TODO: FINISH
  group('Calendar unit test', () {
    testWidgets('Select date on calendar', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      await login(tester);
      await goToCalendarPage(tester);

      final Finder calendarControllerFinger = find.byType(SfCalendar);
      CalendarController t = tester.widget(calendarControllerFinger) as CalendarController;
    });
  });
}