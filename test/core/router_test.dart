import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/core/router/routes.dart';
import 'package:learn_something_today/features/ai/presentation/ai_tools_screen.dart';
import 'package:learn_something_today/features/articles/presentation/article_reader_screen.dart';
import 'package:learn_something_today/features/articles/presentation/home_screen.dart';
import 'package:learn_something_today/features/articles/presentation/search_screen.dart';
import 'package:learn_something_today/features/auth/presentation/sign_in_screen.dart';
import 'package:learn_something_today/features/favourites/presentation/favourites_screen.dart';
import 'package:learn_something_today/features/settings/presentation/settings_screen.dart';

import '../helpers.dart';

void main() {
  group('Routes', () {
    test(
      'articleFor puts the id in the path and the language in the query',
      () {
        expect(
          Routes.articleFor('lalibela', ArticleLanguage.en),
          '/article/lalibela?lang=en',
        );
      },
    );

    test('aiToolsFor extends the article path', () {
      expect(
        Routes.aiToolsFor('lalibela', ArticleLanguage.am),
        '/article/lalibela/ai?lang=am',
      );
    });
  });

  group('bottom navigation', () {
    testWidgets('starts on the home tab with the four destinations', (
      tester,
    ) async {
      await pumpApp(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      final bar = find.byType(NavigationBar);
      for (final label in ['Home', 'Search', 'Favourites', 'Settings']) {
        expect(
          find.descendant(of: bar, matching: find.text(label)),
          findsOneWidget,
        );
      }
    });

    testWidgets('each tab opens its own screen and title', (tester) async {
      await pumpApp(tester);

      await tapTab(tester, 'Search');
      expect(find.byType(SearchScreen), findsOneWidget);

      await tapTab(tester, 'Favourites');
      expect(find.byType(FavouritesScreen), findsOneWidget);

      await tapTab(tester, 'Settings');
      expect(find.byType(SettingsScreen), findsOneWidget);

      await tapTab(tester, 'Home');
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Learn Something Today'),
        ),
        findsOneWidget,
      );
    });
  });

  group('detail routes with parameters', () {
    testWidgets('the id and the language come from the address', (
      tester,
    ) async {
      await pumpApp(
        tester,
        initialLocation: Routes.articleFor('lake-tana', ArticleLanguage.en),
      );

      expect(find.byType(ArticleReaderScreen), findsOneWidget);
      expect(find.textContaining('largest lake in Ethiopia'), findsWidgets);
    });

    testWidgets('a missing language parameter means Amharic', (tester) async {
      await pumpApp(tester, initialLocation: '/article/lake-tana');

      expect(find.text('ጣና ሐይቅ'), findsWidgets);
    });

    testWidgets('the AI tools route nests under the article', (tester) async {
      await pumpApp(
        tester,
        initialLocation: Routes.aiToolsFor('lake-tana', ArticleLanguage.en),
      );

      expect(find.byType(AiToolsScreen), findsOneWidget);
      expect(find.text('Lake Tana'), findsOneWidget);
    });

    testWidgets('the reader hides the tab bar and back returns to the tab', (
      tester,
    ) async {
      await pumpApp(tester);
      await tapTab(tester, 'Search');

      await tester.enterText(find.byType(TextField), 'ጣና');
      await tester.pumpAndSettle();
      await tester.tap(find.text('ጣና ሐይቅ'));
      await tester.pumpAndSettle();
      expect(find.byType(ArticleReaderScreen), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(SearchScreen), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('the language toggle replaces the route instead of stacking', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.tap(find.text('አዲስ አበባ'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();
      expect(find.textContaining('capital and largest city'), findsWidgets);

      // One back press leaves the reader; the toggle did not add a page.
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('other routes', () {
    testWidgets('/ redirects to the home tab', (tester) async {
      await pumpApp(tester, initialLocation: '/');

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('the sign-in route opens without the tab bar', (tester) async {
      await pumpApp(tester, initialLocation: Routes.signIn);

      expect(find.byType(SignInScreen), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('an unknown address shows a not-found page', (tester) async {
      await pumpApp(tester, initialLocation: '/nope');

      expect(find.text('Not found'), findsOneWidget);
      expect(find.text('No page at /nope'), findsOneWidget);
    });
  });
}
