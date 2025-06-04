import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_tracker_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Sign in process test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Splash ekran o'tishi uchun biroz kutamiz (2 soniya)
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Sign In page-da email va password kiritish
    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final signInButton = find.byKey(const Key('sign_in_button'));

    // Input kiritamiz
    await tester.enterText(emailField, 'testuser@example.com');
    await tester.enterText(passwordField, 'TestPassword123');
    await tester.pumpAndSettle();

    // Button bosamiz
    await tester.tap(signInButton);
    await tester.pump(const Duration(seconds: 3)); // button bosilgandan keyin biroz kutish
    await tester.pumpAndSettle();

    // Home page ga o‘tdi deb tekshiramiz
    expect(find.text('Welcome'), findsOneWidget);
  });
}
