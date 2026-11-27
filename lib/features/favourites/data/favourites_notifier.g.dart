// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The saved articles and the operations on them.

@ProviderFor(Favourites)
final favouritesProvider = FavouritesProvider._();

/// The saved articles and the operations on them.
final class FavouritesProvider
    extends $AsyncNotifierProvider<Favourites, List<Favourite>> {
  /// The saved articles and the operations on them.
  FavouritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesHash();

  @$internal
  @override
  Favourites create() => Favourites();
}

String _$favouritesHash() => r'9f8c0dc8209345810ac41de5805513f48db7a377';

/// The saved articles and the operations on them.

abstract class _$Favourites extends $AsyncNotifier<List<Favourite>> {
  FutureOr<List<Favourite>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Favourite>>, List<Favourite>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Favourite>>, List<Favourite>>,
              AsyncValue<List<Favourite>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Whether [articleId] is saved. Widgets watch this to fill the bookmark.

@ProviderFor(isFavourite)
final isFavouriteProvider = IsFavouriteFamily._();

/// Whether [articleId] is saved. Widgets watch this to fill the bookmark.

final class IsFavouriteProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Whether [articleId] is saved. Widgets watch this to fill the bookmark.
  IsFavouriteProvider._({
    required IsFavouriteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isFavouriteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isFavouriteHash();

  @override
  String toString() {
    return r'isFavouriteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return isFavourite(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsFavouriteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isFavouriteHash() => r'802a53a528c446a7d34e68bba54a938a76206229';

/// Whether [articleId] is saved. Widgets watch this to fill the bookmark.

final class IsFavouriteFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  IsFavouriteFamily._()
    : super(
        retry: null,
        name: r'isFavouriteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Whether [articleId] is saved. Widgets watch this to fill the bookmark.

  IsFavouriteProvider call(String articleId) =>
      IsFavouriteProvider._(argument: articleId, from: this);

  @override
  String toString() => r'isFavouriteProvider';
}

/// The saved articles, newest first. Derived state: recomputed only when
/// [favouritesProvider] changes.

@ProviderFor(sortedFavourites)
final sortedFavouritesProvider = SortedFavouritesProvider._();

/// The saved articles, newest first. Derived state: recomputed only when
/// [favouritesProvider] changes.

final class SortedFavouritesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Favourite>>,
          List<Favourite>,
          FutureOr<List<Favourite>>
        >
    with $FutureModifier<List<Favourite>>, $FutureProvider<List<Favourite>> {
  /// The saved articles, newest first. Derived state: recomputed only when
  /// [favouritesProvider] changes.
  SortedFavouritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedFavouritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedFavouritesHash();

  @$internal
  @override
  $FutureProviderElement<List<Favourite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Favourite>> create(Ref ref) {
    return sortedFavourites(ref);
  }
}

String _$sortedFavouritesHash() => r'1417cc9d8d598258f1d8502381f6adfb245f86b5';
