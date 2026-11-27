import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/core/router/routes.dart';
import 'package:learn_something_today/features/ai/presentation/ai_tools_screen.dart';
import 'package:learn_something_today/features/articles/presentation/widgets/fallback_notice.dart';
import 'package:learn_something_today/features/favourites/data/favourites_notifier.dart';

import '../../helpers.dart';

void main() {
  final lalibelaAmharic = Routes.articleFor('lalibela', ArticleLanguage.am);

  testWidgets('shows the article text and the reading time', (tester) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);

    expect(find.text('ላሊበላ'), findsWidgets); // app bar and headline
    expect(find.textContaining('አሥራ አንድ'), findsOneWidget);
    expect(find.text('1 min read'), findsOneWidget);
    expect(find.textContaining('am.wikipedia.org'), findsOneWidget);
  });

  testWidgets('the language toggle switches to the English article', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('Lalibela'), findsWidgets);
    expect(find.textContaining('eleven medieval churches'), findsOneWidget);
    expect(find.textContaining('አሥራ አንድ'), findsNothing);
  });

  testWidgets('says so when only the English article exists', (tester) async {
    await pumpApp(
      tester,
      initialLocation: Routes.articleFor('ethiopian-wolf', ArticleLanguage.am),
    );

    expect(find.byType(FallbackNotice), findsOneWidget);
    expect(find.text('Ethiopian wolf'), findsWidgets);
  });

  testWidgets('an unknown article shows "not found" without a retry button', (
    tester,
  ) async {
    await pumpApp(
      tester,
      initialLocation: Routes.articleFor('nope', ArticleLanguage.en),
    );

    expect(find.text('Article not found.'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('a failing source shows the error, and retry recovers', (
    tester,
  ) async {
    final repository = FlakyArticlesRepository();
    await pumpApp(
      tester,
      initialLocation: lalibelaAmharic,
      articles: repository,
    );
    expect(find.text('The network is down.'), findsOneWidget);

    repository.failing = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.textContaining('አሥራ አንድ'), findsOneWidget);
  });

  testWidgets('the bookmark saves the article and a second tap removes it', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);

    await tester.tap(find.byTooltip('Save to favourites'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Remove from favourites'), findsOneWidget);
    expect(find.text('Saved to favourites'), findsOneWidget);
    final saved = await containerOf(tester).read(favouritesProvider.future);
    expect(saved.single.articleId, 'lalibela');

    await tester.tap(find.byTooltip('Remove from favourites'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Save to favourites'), findsOneWidget);
    expect(find.text('Removed from favourites'), findsOneWidget);
  });

  testWidgets('read aloud toggles the reading banner', (tester) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);
    expect(find.text('Reading aloud'), findsNothing);

    await tester.tap(find.byTooltip('Read aloud'));
    await tester.pumpAndSettle();
    expect(find.text('Reading aloud'), findsOneWidget);

    await tester.tap(find.byTooltip('Stop reading aloud'));
    await tester.pumpAndSettle();
    expect(find.text('Reading aloud'), findsNothing);
  });

  testWidgets('share tells the reader it is not available yet', (tester) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);

    await tester.tap(find.byTooltip('Share'));
    await tester.pumpAndSettle();

    expect(find.text('Sharing is added in the next version.'), findsOneWidget);
  });

  testWidgets('the AI button opens the AI tools for the same article', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);

    await tester.tap(find.text('Simplify or take a quiz'));
    await tester.pumpAndSettle();

    expect(find.byType(AiToolsScreen), findsOneWidget);
    expect(find.text('ላሊበላ'), findsOneWidget);
  });

  testWidgets('every icon-only button has a tooltip for screen readers', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: lalibelaAmharic);

    final buttons = tester.widgetList<IconButton>(find.byType(IconButton));
    expect(buttons, isNotEmpty);
    for (final button in buttons) {
      expect(button.tooltip, isNotNull);
    }
  });
}
