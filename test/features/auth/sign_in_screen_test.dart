import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/router/routes.dart';
import 'package:learn_something_today/features/articles/presentation/home_screen.dart';
import 'package:learn_something_today/features/auth/data/auth_notifier.dart';
import 'package:learn_something_today/features/auth/data/auth_repository.dart';
import 'package:learn_something_today/features/auth/presentation/sign_in_screen.dart';
import 'package:learn_something_today/features/settings/presentation/settings_screen.dart';

import '../../helpers.dart';

void main() {
  Future<void> openSignIn(
    WidgetTester tester, {
    InMemoryAuthRepository? repository,
  }) async {
    await pumpApp(tester, initialLocation: Routes.signIn, auth: repository);
  }

  Future<void> fill(WidgetTester tester, String email, String password) async {
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      password,
    );
  }

  testWidgets('shows what is wrong with an empty form', (tester) async {
    await openSignIn(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Enter your e-mail address.'), findsOneWidget);
    expect(find.text('Enter a password.'), findsOneWidget);
    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('rejects an address that is not an e-mail and a short password', (
    tester,
  ) async {
    await openSignIn(tester);
    await fill(tester, 'not-an-email', '123');

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid e-mail address.'), findsOneWidget);
    expect(find.text('Use at least 6 characters.'), findsOneWidget);
  });

  testWidgets('creating an account signs the reader in and goes home', (
    tester,
  ) async {
    await openSignIn(tester);
    await tester.tap(find.text('Create a new account'));
    await tester.pumpAndSettle();
    expect(find.text('Name (optional)'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name (optional)'),
      'Tigist',
    );
    await fill(tester, 'reader@example.com', 'secret1');

    await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(containerOf(tester).read(authProvider)?.displayName, 'Tigist');
  });

  testWidgets('shows the message when the password is wrong', (tester) async {
    final repository = InMemoryAuthRepository(delay: Duration.zero);
    // Widget tests run on fake time, where a timer only fires when the
    // test pumps. runAsync gives this set-up real time.
    await tester.runAsync(() async {
      await repository.register(
        email: 'reader@example.com',
        password: 'secret1',
      );
      await repository.signOut();
    });
    await openSignIn(tester, repository: repository);
    await fill(tester, 'reader@example.com', 'wrong-one');

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('The password is not correct.'), findsOneWidget);
    expect(find.byType(SignInScreen), findsOneWidget);
    expect(containerOf(tester).read(authProvider), isNull);
  });

  testWidgets('shows the message when the e-mail has no account', (
    tester,
  ) async {
    await openSignIn(tester);
    await fill(tester, 'nobody@example.com', 'secret1');

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('No account uses this e-mail address.'), findsOneWidget);
  });

  testWidgets('the Google demo button signs in', (tester) async {
    await openSignIn(tester);

    await tester.tap(find.text('Continue with Google (demo)'));
    await tester.pumpAndSettle();

    expect(containerOf(tester).read(authProvider)?.displayName, 'Demo reader');
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('a guest can leave without an account', (tester) async {
    await openSignIn(tester);

    await tester.tap(find.text('Continue without an account'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(containerOf(tester).read(authProvider), isNull);
  });

  testWidgets('opened from the settings, it returns to the settings', (
    tester,
  ) async {
    await pumpApp(tester);
    await tapTab(tester, 'Settings');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
    expect(find.byType(SignInScreen), findsOneWidget);

    await tester.tap(find.text('Continue without an account'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
