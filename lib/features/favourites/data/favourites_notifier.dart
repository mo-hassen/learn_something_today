import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../articles/domain/article.dart';
import '../../auth/data/auth_notifier.dart';
import '../domain/favourite.dart';
import 'favourites_repository.dart';

part 'favourites_notifier.g.dart';

/// The saved articles and the operations on them.
@Riverpod(keepAlive: true)
class Favourites extends _$Favourites {
  @override
  Future<List<Favourite>> build() {
    return ref.watch(favouritesRepositoryProvider).loadAll();
  }

  /// Saves the article, or removes it when it is already saved.
  Future<void> toggle(Article article, {DateTime? now}) async {
    final repository = ref.read(favouritesRepositoryProvider);
    final saved = await _isSaved(article.id);
    if (saved) {
      await repository.remove(article.id);
    } else {
      await repository.add(
        Favourite(
          id: 'fav-${article.id}',
          articleId: article.id,
          article: article,
          savedAt: now ?? DateTime.now(),
          userId: ref.read(authProvider)?.id,
        ),
      );
    }
    state = AsyncData(await repository.loadAll());
  }

  Future<void> remove(String articleId) async {
    final repository = ref.read(favouritesRepositoryProvider);
    await repository.remove(articleId);
    state = AsyncData(await repository.loadAll());
  }

  Future<bool> _isSaved(String articleId) async {
    final all = await ref.read(favouritesRepositoryProvider).loadAll();
    return all.any((f) => f.articleId == articleId);
  }
}

/// Whether [articleId] is saved. Widgets watch this to fill the bookmark.
@riverpod
bool isFavourite(Ref ref, String articleId) {
  final favourites = ref.watch(favouritesProvider).value ?? const [];
  return favourites.any((f) => f.articleId == articleId);
}

/// The saved articles, newest first. Derived state: recomputed only when
/// [favouritesProvider] changes.
@riverpod
Future<List<Favourite>> sortedFavourites(Ref ref) async {
  final favourites = await ref.watch(favouritesProvider.future);
  return [...favourites]..sort((a, b) => b.savedAt.compareTo(a.savedAt));
}
