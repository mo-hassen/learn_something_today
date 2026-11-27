import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/features/articles/data/articles_repository.dart';
import 'package:learn_something_today/features/articles/presentation/article_reader_screen.dart';
import 'package:learn_something_today/features/articles/presentation/widgets/fallback_notice.dart';
import 'package:learn_something_today/features/settings/data/settings_notifier.dart';

import '../../helpers.dart';

void main() {
  testWidgets('shows the article of the day and an event from another day', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Article of the day'), findsOneWidget);
    expect(find.text('አዲስ አበባ'), findsOneWidget);
    expect(find.text('On this day'), findsOneWidget);
    // Nothing is recorded for 1 January, so the card names the real date.
    expect(find.text('1896 · 1 March'), findsOneWidget);
  });

  testWidgets('an event on today\'s date shows only its year', (tester) async {
    await pumpApp(tester, now: DateTime(2026, 3));

    expect(find.text('1896'), findsOneWidget);
    expect(find.textContaining('·'), findsNothing);
  });

  testWidgets('shows a notice when the article is only in English', (
    tester,
  ) async {
    await pumpApp(tester, now: fallbackClock);

    expect(find.text('Ethiopian wolf'), findsOneWidget);
    expect(find.byType(FallbackNotice), findsOneWidget);
    expect(find.textContaining('no Amharic article'), findsOneWidget);
  });

  testWidgets('the language toggle switches the home feed to English', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('Addis Ababa'), findsOneWidget);
    expect(find.text('አዲስ አበባ'), findsNothing);
    expect(
      containerOf(tester).read(settingsProvider).preferredLanguage.code,
      'en',
    );
  });

  testWidgets('tapping the article opens the reader; back returns home', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('አዲስ አበባ'));
    await tester.pumpAndSettle();
    expect(find.byType(ArticleReaderScreen), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Article of the day'), findsOneWidget);
  });

  testWidgets('tapping an event opens the article it links to', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('1896 · 1 March'));
    await tester.pumpAndSettle();

    expect(find.byType(ArticleReaderScreen), findsOneWidget);
    expect(find.text('የዓድዋ ጦርነት'), findsWidgets);
  });

  testWidgets('shows a message when no event is recorded', (tester) async {
    await pumpApp(
      tester,
      articles: InMemoryArticlesRepository(
        delay: Duration.zero,
        facts: const [],
      ),
    );

    expect(find.text('No events are recorded for today.'), findsOneWidget);
    expect(find.text('አዲስ አበባ'), findsOneWidget);
  });

  testWidgets('shows a loading indicator while the data is on its way', (
    tester,
  ) async {
    await pumpApp(
      tester,
      settle: false,
      articles: InMemoryArticlesRepository(delay: const Duration(seconds: 1)),
    );

    // Both sections are still waiting for the repository.
    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    expect(find.text('አዲስ አበባ'), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('አዲስ አበባ'), findsOneWidget);
  });

  group('when the source fails', () {
    testWidgets('shows the error with a retry button, and retry recovers', (
      tester,
    ) async {
      final repository = FlakyArticlesRepository();
      await pumpApp(tester, articles: repository);

      // One message for the article and one for the events.
      expect(find.text('The network is down.'), findsNWidgets(2));
      expect(find.text('አዲስ አበባ'), findsNothing);

      repository.failing = false;
      await tester.tap(find.text('Retry').first);
      await tester.pumpAndSettle();

      expect(find.text('አዲስ አበባ'), findsOneWidget);
      expect(find.text('The network is down.'), findsOneWidget);
    });

    testWidgets('pulling down refreshes both sections', (tester) async {
      final repository = FlakyArticlesRepository();
      await pumpApp(tester, articles: repository);
      expect(find.text('The network is down.'), findsNWidgets(2));

      repository.failing = false;
      // The indicator arms after a pull of a quarter of the screen height.
      await tester.fling(find.byType(ListView), const Offset(0, 800), 1000);
      await tester.pumpAndSettle();

      expect(find.text('The network is down.'), findsNothing);
      expect(find.text('አዲስ አበባ'), findsOneWidget);
      expect(find.text('1896 · 1 March'), findsOneWidget);
    });
  });
}
