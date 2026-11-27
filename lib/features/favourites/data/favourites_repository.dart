import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/favourite.dart';

part 'favourites_repository.g.dart';

/// Where saved articles are kept. Milestone 2 adds a drift database for
/// offline reading and a Firestore copy for syncing between devices.
abstract interface class FavouritesRepository {
  Future<List<Favourite>> loadAll();

  /// Saves [favourite]; saving the same article again replaces it.
  Future<void> add(Favourite favourite);

  Future<void> remove(String articleId);
}

/// Keeps the favourites in memory: they are lost when the app closes.
class InMemoryFavouritesRepository implements FavouritesRepository {
  final _items = <String, Favourite>{};

  @override
  Future<List<Favourite>> loadAll() async => List.unmodifiable(_items.values);

  @override
  Future<void> add(Favourite favourite) async {
    _items[favourite.articleId] = favourite;
  }

  @override
  Future<void> remove(String articleId) async {
    _items.remove(articleId);
  }
}

/// Kept alive on purpose: an in-memory repository that was disposed when no
/// screen watched it would forget every favourite.
@Riverpod(keepAlive: true)
FavouritesRepository favouritesRepository(Ref ref) {
  return InMemoryFavouritesRepository();
}
