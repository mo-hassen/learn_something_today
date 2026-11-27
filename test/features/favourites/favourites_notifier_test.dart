import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/features/auth/data/auth_notifier.dart';
import 'package:learn_something_today/features/auth/data/auth_repository.dart';
import 'package:learn_something_today/features/favourites/data/favourites_notifier.dart';

import '../../helpers.dart';

void main() {
  // A ProviderContainer is a ProviderScope without widgets: the way to
  // unit-test providers.
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer.test(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          InMemoryAuthRepository(delay: Duration.zero),
        ),
      ],
    );
  });

  Future<List<String>> savedIds() async {
    final all = await container.read(favouritesProvider.future);
    return [for (final f in all) f.articleId];
  }

  test('starts empty', () async {
    expect(await savedIds(), isEmpty);
    expect(container.read(isFavouriteProvider('a')), isFalse);
  });

  test('toggle saves an article, and toggling again removes it', () async {
    final notifier = container.read(favouritesProvider.notifier);
    final article = testArticle(id: 'a');

    await notifier.toggle(article);
    expect(await savedIds(), ['a']);
    expect(container.read(isFavouriteProvider('a')), isTrue);

    await notifier.toggle(article);
    expect(await savedIds(), isEmpty);
    expect(container.read(isFavouriteProvider('a')), isFalse);
  });

  test('keeps the article text so it can be read again', () async {
    final notifier = container.read(favouritesProvider.notifier);
    await notifier.toggle(testArticle(id: 'a', title: 'Kept'));
    final saved = (await container.read(favouritesProvider.future)).single;
    expect(saved.article.title, 'Kept');
    expect(saved.article.paragraphs, hasLength(2));
  });

  test('remove deletes one article and leaves the others', () async {
    final notifier = container.read(favouritesProvider.notifier);
    await notifier.toggle(testArticle(id: 'a'));
    await notifier.toggle(testArticle(id: 'b'));
    await notifier.remove('a');
    expect(await savedIds(), ['b']);
  });

  test('sortedFavourites puts the newest first', () async {
    final notifier = container.read(favouritesProvider.notifier);
    await notifier.toggle(testArticle(id: 'old'), now: DateTime(2026, 1, 1));
    await notifier.toggle(testArticle(id: 'new'), now: DateTime(2026, 1, 3));
    await notifier.toggle(testArticle(id: 'mid'), now: DateTime(2026, 1, 2));
    final sorted = await container.read(sortedFavouritesProvider.future);
    expect([for (final f in sorted) f.articleId], ['new', 'mid', 'old']);
  });

  test('a guest favourite has no user id; a signed-in one has', () async {
    final notifier = container.read(favouritesProvider.notifier);
    await notifier.toggle(testArticle(id: 'guest'));
    await container
        .read(authProvider.notifier)
        .register(email: 'reader@example.com', password: 'secret1');
    await notifier.toggle(testArticle(id: 'member'));

    final all = await container.read(favouritesProvider.future);
    expect(all.firstWhere((f) => f.articleId == 'guest').userId, isNull);
    expect(all.firstWhere((f) => f.articleId == 'member').userId, 'u1');
  });

  test('the state is immutable: the exposed list cannot be changed', () async {
    final notifier = container.read(favouritesProvider.notifier);
    await notifier.toggle(testArticle(id: 'a'));
    final list = await container.read(favouritesProvider.future);
    expect(list.clear, throwsUnsupportedError);
  });
}
