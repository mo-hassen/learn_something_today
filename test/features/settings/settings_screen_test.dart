import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/features/auth/data/auth_notifier.dart';
import 'package:learn_something_today/features/auth/presentation/sign_in_screen.dart';
import 'package:learn_something_today/features/settings/data/settings_notifier.dart';

import '../../helpers.dart';

void main() {
  Future<void> openSettings(WidgetTester tester) async {
    await pumpApp(tester);
    await tapTab(tester, 'Settings');
  }

  testWidgets('the language toggle changes the preferred language', (
    tester,
  ) async {
    await openSettings(tester);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(
      containerOf(tester).read(settingsProvider).preferredLanguage,
      ArticleLanguage.en,
    );
  });

  testWidgets('the home feed follows the language chosen in the settings', (
    tester,
  ) async {
    await openSettings(tester);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    await tapTab(tester, 'Home');

    expect(find.text('Addis Ababa'), findsOneWidget);
  });

  testWidgets('changing the language after visiting every tab updates them', (
    tester,
  ) async {
    // Regression test: Home and Search are hidden while the language
    // changes, and their providers depend on it.
    await pumpApp(tester);
    await tapTab(tester, 'Search');
    await tester.enterText(find.byType(TextField), 'ጣና');
    await tester.pumpAndSettle();
    await tapTab(tester, 'Favourites');
    await tapTab(tester, 'Settings');

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tapTab(tester, 'Home');
    expect(find.text('Addis Ababa'), findsOneWidget);
    // The Amharic word no longer matches: the search ran again in English.
    await tapTab(tester, 'Search');
    expect(find.text('No article matches "ጣና".'), findsOneWidget);
  });

  testWidgets('the slider changes the text size of the whole app', (
    tester,
  ) async {
    await openSettings(tester);
    final before = MediaQuery.textScalerOf(tester.element(find.byType(Slider)))
        .scale(10);

    await tester.drag(find.byType(Slider), const Offset(400, 0));
    await tester.pumpAndSettle();

    final after = MediaQuery.textScalerOf(tester.element(find.byType(Slider)))
        .scale(10);
    expect(before, 10);
    expect(after, greaterThan(before));
    expect(
      containerOf(tester).read(settingsProvider).fontScale,
      closeTo(after / 10, 0.001),
    );
  });

  testWidgets('the reminder switch is stored', (tester) async {
    await openSettings(tester);
    expect(containerOf(tester).read(settingsProvider).dailyNotification, false);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(containerOf(tester).read(settingsProvider).dailyNotification, true);
  });

  testWidgets('a guest sees a sign-in button that opens the form', (
    tester,
  ) async {
    await openSettings(tester);
    expect(find.text('You are not signed in'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('a signed-in reader sees the account and can sign out', (
    tester,
  ) async {
    await openSettings(tester);
    // runAsync: the repository waits on a timer, and widget tests run on
    // fake time.
    await tester.runAsync(
      () => containerOf(tester)
          .read(authProvider.notifier)
          .register(
            email: 'reader@example.com',
            password: 'secret1',
            displayName: 'Tigist',
          ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tigist'), findsOneWidget);
    expect(find.text('reader@example.com'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(find.text('You are not signed in'), findsOneWidget);
    expect(containerOf(tester).read(authProvider), isNull);
  });
}
