import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mac_fi/main.dart' as app;

Future<void> loginProfessor(WidgetTester tester) async {
  // Enter text in the email field
  final Finder emailField = find.byKey(const Key('matrícula_form'));
  await tester.enterText(emailField, '1234560');
  await tester.pumpAndSettle();

  // Enter text in the password field
  final Finder passwordField = find.byKey(const Key('senha_form'));
  await tester.enterText(passwordField, 'senha');
  await tester.pumpAndSettle();

  // Tap on the login button
  final Finder loginButton = find.byKey(const Key('entrar_button'));
  await tester.tap(loginButton);
  await tester.pumpAndSettle();
}

Future<void> loginAluno(WidgetTester tester) async {
  // Enter text in the email field
  final Finder emailField = find.byKey(const Key('matrícula_form'));
  await tester.enterText(emailField, '123456710');
  await tester.pumpAndSettle();

  // Enter text in the password field
  final Finder passwordField = find.byKey(const Key('senha_form'));
  await tester.enterText(passwordField, 'senha');
  await tester.pumpAndSettle();

  // Tap on the login button
  final Finder loginButton = find.byKey(const Key('entrar_button'));
  await tester.tap(loginButton);
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Test Cases', () {
    testWidgets('Login Valid Professor', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '1234560');
      await tester.pumpAndSettle();

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, 'senha');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find the teacher's home screen
      expect(find.byKey(const Key('iniciar_chamada_button')), findsOneWidget);
    });

    testWidgets('Login Valid Student', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '123456710');
      await tester.pumpAndSettle();

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, 'senha');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find the student's home screen
      expect(find.text('Registre sua presença!'), findsOneWidget);
    });

    testWidgets('Login Invalid', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '111');
      await tester.pumpAndSettle();

      final Finder errorMatricula =
          find.text('Número incorreto de dígitos para matrícula/SIAPE');

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, '12');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find the error message
      expect(errorMatricula, findsOneWidget);
    });

    testWidgets('Login Email Mandatory', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '');
      await tester.pumpAndSettle();

      final Finder errorMatricula =
          find.text('O campo matrícula/SIAPE é obrigatório');

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, '12');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find the error message
      expect(errorMatricula, findsOneWidget);
    });

    testWidgets('Login Password Mandatory', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '1111111111');
      await tester.pumpAndSettle();

      final Finder errorPassword = find.text('O campo é obrigatório');

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, '');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find the error message
      expect(errorPassword, findsOneWidget);
    });

    testWidgets('Logout', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '1234560');
      await tester.pumpAndSettle();

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, 'senha');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find the home screen
      expect(find.byKey(const Key('iniciar_chamada_button')), findsOneWidget);

      final Finder turmasButton = find.byKey(const Key('turmas_button'));
      await tester.tap(turmasButton);
      await tester.pumpAndSettle();

      final Finder perfilBox = find.byKey(const Key('perfil_box'));
      await tester.tap(perfilBox);
      await tester.pumpAndSettle();

      final Finder sairBox = find.byKey(const Key('sair_box'));
      await tester.tap(sairBox);
      await tester.pumpAndSettle();

      final Finder confirmarLogoutButton =
          find.byKey(const Key('confirmar_logout_button'));
      await tester.tap(confirmarLogoutButton);
      await tester.pumpAndSettle();

      expect(emailField, findsOneWidget);
    });

    testWidgets('Login not registered teacher', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '1111111');
      await tester.pumpAndSettle();

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, '12');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find error message
      expect(find.text('Infelizmente não encontramos o seu cadastro'), findsOneWidget);
    });

    testWidgets('Login not registered student', (WidgetTester tester) async {
      // Run the app
      app.main();
      await tester.pumpAndSettle();

      // Enter text in the email field
      final Finder emailField = find.byKey(const Key('matrícula_form'));
      await tester.enterText(emailField, '111111111');
      await tester.pumpAndSettle();

      // Enter text in the password field
      final Finder passwordField = find.byKey(const Key('senha_form'));
      await tester.enterText(passwordField, '12');
      await tester.pumpAndSettle();

      // Tap on the login button
      final Finder loginButton = find.byKey(const Key('entrar_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Expect to find error message
      expect(find.text('Infelizmente não encontramos o seu cadastro'), findsOneWidget);
    });
  });
}
