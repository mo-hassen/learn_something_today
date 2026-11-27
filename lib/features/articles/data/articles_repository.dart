import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/article_language.dart';
import '../../../core/network/app_exception.dart';
import '../domain/article.dart';
import '../domain/on_this_day_fact.dart';
import 'sample_articles.dart';

part 'articles_repository.g.dart';

/// What the app needs from an article source. The screens and providers
/// depend on this interface. Milestone 2 adds an implementation that calls
/// the Wikipedia REST API, and nothing above this line changes.
abstract interface class ArticlesRepository {
  /// The article of the day. When [language] has no version of it, the
  /// English version comes back with `isFallback` set.
  Future<Article> featuredArticle(DateTime date, ArticleLanguage language);

  /// The events recorded for [date]; when there are none, one event from
  /// another day, so the home screen is never empty.
  Future<List<OnThisDayFact>> onThisDay(
    DateTime date,
    ArticleLanguage language,
  );

  /// One article by id. Throws [NotFoundException] for an unknown id.
  Future<Article> article(String id, ArticleLanguage language);

  /// Articles whose title or summary contains [query]. A blank query
  /// returns an empty list.
  Future<List<Article>> search(String query, ArticleLanguage language);
}

/// In-memory implementation with a short artificial delay, so the loading
/// state can be seen.
class InMemoryArticlesRepository implements ArticlesRepository {
  InMemoryArticlesRepository({
    List<ArticleSeed>? articles,
    List<FactSeed>? facts,
    this.delay = const Duration(milliseconds: 400),
  }) : _articles = articles ?? sampleArticles,
       _facts = facts ?? sampleFacts;

  final List<ArticleSeed> _articles;
  final List<FactSeed> _facts;
  final Duration delay;

  static final _updatedAt = DateTime(2026, 10, 1);

  Future<void> _wait() => Future<void>.delayed(delay);

  /// Days since 1 January, used to rotate through the sample content.
  int _dayOfYear(DateTime date) => date.difference(DateTime(date.year)).inDays;

  @override
  Future<Article> featuredArticle(
    DateTime date,
    ArticleLanguage language,
  ) async {
    await _wait();
    final seed = _articles[_dayOfYear(date) % _articles.length];
    return _toArticle(seed, language);
  }

  @override
  Future<List<OnThisDayFact>> onThisDay(
    DateTime date,
    ArticleLanguage language,
  ) async {
    await _wait();
    if (_facts.isEmpty) return const [];
    final today = _facts.where(
      (f) => f.month == date.month && f.day == date.day,
    );
    final chosen = today.isNotEmpty
        ? today.toList()
        : [_facts[_dayOfYear(date) % _facts.length]];
    return List.unmodifiable([
      for (final seed in chosen)
        OnThisDayFact(
          id: seed.id,
          year: seed.year,
          month: seed.month,
          day: seed.day,
          text: language == ArticleLanguage.am ? seed.am : seed.en,
          language: language,
          relatedArticleId: seed.relatedArticleId,
        ),
    ]);
  }

  @override
  Future<Article> article(String id, ArticleLanguage language) async {
    await _wait();
    final seed = _articles.where((a) => a.id == id).firstOrNull;
    if (seed == null) throw const NotFoundException('Article not found.');
    return _toArticle(seed, language);
  }

  @override
  Future<List<Article>> search(String query, ArticleLanguage language) async {
    await _wait();
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return const [];
    return List.unmodifiable([
      for (final seed in _articles)
        if (_matches(seed, language, needle)) _toArticle(seed, language),
    ]);
  }

  bool _matches(ArticleSeed seed, ArticleLanguage language, String needle) {
    final text = seed.text(language) ?? seed.en;
    return text.title.toLowerCase().contains(needle) ||
        text.summary.toLowerCase().contains(needle);
  }

  Article _toArticle(ArticleSeed seed, ArticleLanguage language) {
    final wanted = seed.text(language);
    final text = wanted ?? seed.en;
    final shown = wanted == null ? ArticleLanguage.en : language;
    return Article(
      id: seed.id,
      title: text.title,
      language: shown,
      summary: text.summary,
      fullText: text.paragraphs.join('\n\n'),
      articleUrl:
          'https://${shown.code}.wikipedia.org/wiki/'
          '${Uri.encodeComponent(text.title.replaceAll(' ', '_'))}',
      updatedAt: _updatedAt,
      isFallback: wanted == null,
    );
  }
}

/// The repository as a provider. Tests replace it with
/// `articlesRepositoryProvider.overrideWithValue(...)`.
@Riverpod(keepAlive: true)
ArticlesRepository articlesRepository(Ref ref) => InMemoryArticlesRepository();
