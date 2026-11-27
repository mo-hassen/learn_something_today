import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/features/articles/presentation/article_reader_screen.dart';
import 'package:learn_something_today/features/auth/presentation/sign_in_screen.dart';
import 'package:learn_something_today/features/favourites/data/favourites_repository.dart';
import 'package:learn_something_today/features/favourites/domain/favourite.dart';

import '../../helpers.dart';

Favourite _favourite(String id, String title, DateTime savedAt) {
  final article = testArticle(
    id: id,
    title: title,
    language: ArticleLanguage.en,
  );
  return Favourite(
    id: 'fav-$id',
    articleId: id,
    article: article,
    savedAt: savedAt,
  );
}

void main() {
  Future<void> openFavourites(
    WidgetTester tester, {
    List<Favourite> saved = const [],
  }) async {
    final repository = InMemoryFavouritesRepository();
    for (final favourite in saved) {
      await repository.add(favourite);
    }
    await pumpApp(tester, favourites: repository);
    await tapTab(tester, 'Favourites');
  }

  testWidgets('shows a hint when nothing is saved', (tester) async {
    await openFavourites(tester);

    expect(find.textContaining('No saved articles yet'), findsOneWidget);
  });

  testWidgets('lists the saved articles, newest first', (tester) async {
    await openFavourites(
      tester,
      saved: [
        _favourite('old', 'Older article', DateTime(2026, 1, 1)),
        _favourite('new', 'Newer article', DateTime(2026, 1, 9)),
      ],
    );

    expect(find.text('Newer article'), findsOneWidget);
    expect(find.text('Older article'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Newer article')).dy,
      lessThan(tester.getTopLeft(find.text('Older article')).dy),
    );
    expect(find.textContaining('saved 2026-01-09'), findsOneWidget);
  });

  testWidgets('the delete button removes an article', (tester) async {
    await openFavourites(
      tester,
      saved: [_favourite('a', 'Article A', DateTime(2026, 1, 1))],
    );

    await tester.tap(find.byTooltip('Remove from favourites'));
    await tester.pumpAndSettle();

    expect(find.text('Article A'), findsNothing);
    expect(find.textContaining('No saved articles yet'), findsOneWidget);
  });

  testWidgets('swiping an article away removes it', (tester) async {
    await openFavourites(
      tester,
      saved: [_favourite('a', 'Article A', DateTime(2026, 1, 1))],
    );

    await tester.drag(find.byType(Dismissible), const Offset(-600, 0));
    await tester.pumpAndSettle();

    expect(find.text('Article A'), findsNothing);
  });

  testWidgets('tapping an article opens it in the reader', (tester) async {
    await openFavourites(
      tester,
      saved: [_favourite('lalibela', 'Lalibela', DateTime(2026, 1, 1))],
    );

    await tester.tap(find.text('Lalibela'));
    await tester.pumpAndSettle();

    expect(find.byType(ArticleReaderScreen), findsOneWidget);
    expect(find.textContaining('eleven medieval churches'), findsOneWidget);
  });

  testWidgets('a guest is invited to sign in', (tester) async {
    await openFavourites(tester);

    expect(find.text('Sign in to sync your favourites'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('an article saved in the reader appears in the list', (
    tester,
  ) async {
    await pumpApp(tester);
    // Regression test: visit Favourites first, so its providers are
    // listening while the article is saved from another screen.
    await tapTab(tester, 'Favourites');
    await tapTab(tester, 'Home');
    await tester.tap(find.text('አዲስ አበባ'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save to favourites'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await tapTab(tester, 'Favourites');

    expect(find.text('አዲስ አበባ'), findsOneWidget);
    expect(find.textContaining('No saved articles yet'), findsNothing);
  });
}
