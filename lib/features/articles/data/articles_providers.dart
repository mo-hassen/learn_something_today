import 'package:riverpod/riverpod.dart' show ProviderListenableSelect;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/article_language.dart';
import '../../../core/time/now_provider.dart';
import '../../settings/data/settings_notifier.dart';
import '../domain/article.dart';
import '../domain/on_this_day_fact.dart';
import 'articles_repository.dart';

part 'articles_providers.g.dart';

/// The reader's preferred language, taken from the settings.
@riverpod
ArticleLanguage preferredLanguage(Ref ref) {
  return ref.watch(settingsProvider.select((s) => s.preferredLanguage));
}

/// Today's featured article in the preferred language. A `Future`
/// provider: widgets see an `AsyncValue` with loading, data and error.
@riverpod
Future<Article> dailyArticle(Ref ref) {
  final language = ref.watch(preferredLanguageProvider);
  final today = ref.watch(nowProvider);
  return ref.watch(articlesRepositoryProvider).featuredArticle(today, language);
}

/// The "On This Day" events for today.
@riverpod
Future<List<OnThisDayFact>> onThisDay(Ref ref) {
  final language = ref.watch(preferredLanguageProvider);
  final today = ref.watch(nowProvider);
  return ref.watch(articlesRepositoryProvider).onThisDay(today, language);
}

/// One article in one language. A *family*: every pair of arguments is
/// cached on its own, as in `articleProvider('lalibela', ArticleLanguage.am)`.
@riverpod
Future<Article> article(Ref ref, String id, ArticleLanguage language) {
  return ref.watch(articlesRepositoryProvider).article(id, language);
}

/// The text in the search box.
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

/// The articles that match [searchQueryProvider] in the preferred language.
@riverpod
Future<List<Article>> searchResults(Ref ref) {
  final query = ref.watch(searchQueryProvider);
  final language = ref.watch(preferredLanguageProvider);
  return ref.watch(articlesRepositoryProvider).search(query, language);
}
