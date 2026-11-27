// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The repository as a provider. Tests replace it with
/// `articlesRepositoryProvider.overrideWithValue(...)`.

@ProviderFor(articlesRepository)
final articlesRepositoryProvider = ArticlesRepositoryProvider._();

/// The repository as a provider. Tests replace it with
/// `articlesRepositoryProvider.overrideWithValue(...)`.

final class ArticlesRepositoryProvider
    extends
        $FunctionalProvider<
          ArticlesRepository,
          ArticlesRepository,
          ArticlesRepository
        >
    with $Provider<ArticlesRepository> {
  /// The repository as a provider. Tests replace it with
  /// `articlesRepositoryProvider.overrideWithValue(...)`.
  ArticlesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'articlesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$articlesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ArticlesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ArticlesRepository create(Ref ref) {
    return articlesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticlesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticlesRepository>(value),
    );
  }
}

String _$articlesRepositoryHash() =>
    r'ca1a4f711b7707eeb4497a5cb85a9ba7b4ea1124';
