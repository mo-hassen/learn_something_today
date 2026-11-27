import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/features/articles/presentation/article_reader_screen.dart';
import 'package:learn_something_today/features/articles/presentation/search_screen.dart';

import '../../helpers.dart';

void main() {
  Future<void> openSearch(
    WidgetTester tester, {
    FlakyArticlesRepository? repository,
  }) async {
    await pumpApp(tester, articles: repository);
    await tapTab(tester, 'Search');
  }

  Future<void> search(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.pumpAndSettle();
  }

  testWidgets('asks for a word before it shows anything', (tester) async {
    await openSearch(tester);

    expect(find.byType(SearchScreen), findsOneWidget);
    expect(find.text('Type a word to search the articles.'), findsOneWidget);
  });

  testWidgets('lists the articles that match the word', (tester) async {
    await openSearch(tester);

    await search(tester, 'ጣና');

    expect(find.text('ጣና ሐይቅ'), findsOneWidget);
    expect(find.text('ላሊበላ'), findsNothing);
  });

  testWidgets('says so when nothing matches', (tester) async {
    await openSearch(tester);

    await search(tester, 'zzzz');

    expect(find.text('No article matches "zzzz".'), findsOneWidget);
  });

  testWidgets('a result opens the article', (tester) async {
    await openSearch(tester);
    await search(tester, 'ላሊ');

    await tester.tap(find.text('ላሊበላ'));
    await tester.pumpAndSettle();

    expect(find.byType(ArticleReaderScreen), findsOneWidget);
    expect(find.textContaining('አሥራ አንድ'), findsOneWidget);
  });

  testWidgets('clearing the box returns to the prompt', (tester) async {
    await openSearch(tester);
    await search(tester, 'ጣና');

    await search(tester, '');

    expect(find.text('Type a word to search the articles.'), findsOneWidget);
  });

  testWidgets('the text survives a switch to another tab and back', (
    tester,
  ) async {
    await openSearch(tester);
    await search(tester, 'ጣና');

    await tapTab(tester, 'Settings');
    await tapTab(tester, 'Search');

    expect(find.widgetWithText(TextField, 'ጣና'), findsOneWidget);
    expect(find.text('ጣና ሐይቅ'), findsOneWidget);
  });

  testWidgets('shows the error when the source fails, and retry recovers', (
    tester,
  ) async {
    final repository = FlakyArticlesRepository();
    await openSearch(tester, repository: repository);
    // Typing starts a search that fails.
    await search(tester, 'ጣና');
    expect(find.text('The network is down.'), findsOneWidget);

    repository.failing = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('ጣና ሐይቅ'), findsOneWidget);
  });
}
