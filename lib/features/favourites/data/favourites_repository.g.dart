// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kept alive on purpose: an in-memory repository that was disposed when no
/// screen watched it would forget every favourite.

@ProviderFor(favouritesRepository)
final favouritesRepositoryProvider = FavouritesRepositoryProvider._();

/// Kept alive on purpose: an in-memory repository that was disposed when no
/// screen watched it would forget every favourite.

final class FavouritesRepositoryProvider
    extends
        $FunctionalProvider<
          FavouritesRepository,
          FavouritesRepository,
          FavouritesRepository
        >
    with $Provider<FavouritesRepository> {
  /// Kept alive on purpose: an in-memory repository that was disposed when no
  /// screen watched it would forget every favourite.
  FavouritesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavouritesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavouritesRepository create(Ref ref) {
    return favouritesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavouritesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavouritesRepository>(value),
    );
  }
}

String _$favouritesRepositoryHash() =>
    r'75d5a1337eabc7a5ae35ca33271e9aa7b7e4f7c2';
