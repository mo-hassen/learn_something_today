// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reader's preferred language, taken from the settings.

@ProviderFor(preferredLanguage)
final preferredLanguageProvider = PreferredLanguageProvider._();

/// The reader's preferred language, taken from the settings.

final class PreferredLanguageProvider
    extends
        $FunctionalProvider<ArticleLanguage, ArticleLanguage, ArticleLanguage>
    with $Provider<ArticleLanguage> {
  /// The reader's preferred language, taken from the settings.
  PreferredLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferredLanguageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferredLanguageHash();

  @$internal
  @override
  $ProviderElement<ArticleLanguage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ArticleLanguage create(Ref ref) {
    return preferredLanguage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticleLanguage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticleLanguage>(value),
    );
  }
}

String _$preferredLanguageHash() => r'5adfde93242f8041fedfc6222374c816240de883';

/// Today's featured article in the preferred language. A `Future`
/// provider: widgets see an `AsyncValue` with loading, data and error.

@ProviderFor(dailyArticle)
final dailyArticleProvider = DailyArticleProvider._();

/// Today's featured article in the preferred language. A `Future`
/// provider: widgets see an `AsyncValue` with loading, data and error.

final class DailyArticleProvider
    extends $FunctionalProvider<AsyncValue<Article>, Article, FutureOr<Article>>
    with $FutureModifier<Article>, $FutureProvider<Article> {
  /// Today's featured article in the preferred language. A `Future`
  /// provider: widgets see an `AsyncValue` with loading, data and error.
  DailyArticleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyArticleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyArticleHash();

  @$internal
  @override
  $FutureProviderElement<Article> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Article> create(Ref ref) {
    return dailyArticle(ref);
  }
}

String _$dailyArticleHash() => r'fb4e88bf0c65c0b8e5bbf0a7a3d754d9dae3b2ff';

/// The "On This Day" events for today.

@ProviderFor(onThisDay)
final onThisDayProvider = OnThisDayProvider._();

/// The "On This Day" events for today.

final class OnThisDayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OnThisDayFact>>,
          List<OnThisDayFact>,
          FutureOr<List<OnThisDayFact>>
        >
    with
        $FutureModifier<List<OnThisDayFact>>,
        $FutureProvider<List<OnThisDayFact>> {
  /// The "On This Day" events for today.
  OnThisDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onThisDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onThisDayHash();

  @$internal
  @override
  $FutureProviderElement<List<OnThisDayFact>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OnThisDayFact>> create(Ref ref) {
    return onThisDay(ref);
  }
}

String _$onThisDayHash() => r'fd44c4075551e271ff7ab7823909916e19f88618';

/// One article in one language. A *family*: every pair of arguments is
/// cached on its own, as in `articleProvider('lalibela', ArticleLanguage.am)`.

@ProviderFor(article)
final articleProvider = ArticleFamily._();

/// One article in one language. A *family*: every pair of arguments is
/// cached on its own, as in `articleProvider('lalibela', ArticleLanguage.am)`.

final class ArticleProvider
    extends $FunctionalProvider<AsyncValue<Article>, Article, FutureOr<Article>>
    with $FutureModifier<Article>, $FutureProvider<Article> {
  /// One article in one language. A *family*: every pair of arguments is
  /// cached on its own, as in `articleProvider('lalibela', ArticleLanguage.am)`.
  ArticleProvider._({
    required ArticleFamily super.from,
    required (String, ArticleLanguage) super.argument,
  }) : super(
         retry: null,
         name: r'articleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleHash();

  @override
  String toString() {
    return r'articleProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Article> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Article> create(Ref ref) {
    final argument = this.argument as (String, ArticleLanguage);
    return article(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleHash() => r'bbac5928fdc531abc835d5278caf71db63243820';

/// One article in one language. A *family*: every pair of arguments is
/// cached on its own, as in `articleProvider('lalibela', ArticleLanguage.am)`.

final class ArticleFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Article>,
          (String, ArticleLanguage)
        > {
  ArticleFamily._()
    : super(
        retry: null,
        name: r'articleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One article in one language. A *family*: every pair of arguments is
  /// cached on its own, as in `articleProvider('lalibela', ArticleLanguage.am)`.

  ArticleProvider call(String id, ArticleLanguage language) =>
      ArticleProvider._(argument: (id, language), from: this);

  @override
  String toString() => r'articleProvider';
}

/// The text in the search box.

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

/// The text in the search box.
final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  /// The text in the search box.
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'2ab221c441fd042c8cbf58b17e7e766363f36b6f';

/// The text in the search box.

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The articles that match [searchQueryProvider] in the preferred language.

@ProviderFor(searchResults)
final searchResultsProvider = SearchResultsProvider._();

/// The articles that match [searchQueryProvider] in the preferred language.

final class SearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  /// The articles that match [searchQueryProvider] in the preferred language.
  SearchResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    return searchResults(ref);
  }
}

String _$searchResultsHash() => r'7a3151b6a1a435adc961f3f5b9b4e35c05a43844';
