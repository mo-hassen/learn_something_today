import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/core/network/app_exception.dart';
import 'package:learn_something_today/features/articles/data/articles_repository.dart';

void main() {
  late InMemoryArticlesRepository repository;

  setUp(() {
    repository = InMemoryArticlesRepository(delay: Duration.zero);
  });

  group('article', () {
    test('returns the Amharic version when it exists', () async {
      final article = await repository.article('lalibela', ArticleLanguage.am);
      expect(article.title, 'ላሊበላ');
      expect(article.language, ArticleLanguage.am);
      expect(article.isFallback, isFalse);
    });

    test('falls back to English when there is no Amharic article', () async {
      final article = await repository.article(
        'ethiopian-wolf',
        ArticleLanguage.am,
      );
      expect(article.title, 'Ethiopian wolf');
      expect(article.language, ArticleLanguage.en);
      expect(article.isFallback, isTrue);
    });

    test('English is never a fallback', () async {
      final article = await repository.article(
        'ethiopian-wolf',
        ArticleLanguage.en,
      );
      expect(article.isFallback, isFalse);
    });

    test('throws NotFoundException for an unknown id', () {
      expect(
        repository.article('nope', ArticleLanguage.en),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('builds the Wikipedia address in the language shown', () async {
      final english = await repository.article('lake-tana', ArticleLanguage.en);
      expect(english.articleUrl, 'https://en.wikipedia.org/wiki/Lake_Tana');
      final amharic = await repository.article('lake-tana', ArticleLanguage.am);
      expect(amharic.articleUrl, startsWith('https://am.wikipedia.org/wiki/'));
    });
  });

  group('featuredArticle', () {
    test('rotates through the articles one day at a time', () async {
      final first = await repository.featuredArticle(
        DateTime(2026),
        ArticleLanguage.en,
      );
      final second = await repository.featuredArticle(
        DateTime(2026, 1, 2),
        ArticleLanguage.en,
      );
      expect(first.id, 'addis-ababa');
      expect(second.id, 'lalibela');
    });

    test('is the same article all day', () async {
      final morning = await repository.featuredArticle(
        DateTime(2026, 5, 5, 8),
        ArticleLanguage.en,
      );
      final evening = await repository.featuredArticle(
        DateTime(2026, 5, 5, 21),
        ArticleLanguage.en,
      );
      expect(morning.id, evening.id);
    });

    test(
      'falls back to English on a day whose article has no Amharic',
      () async {
        final article = await repository.featuredArticle(
          DateTime(2026, 1, 6),
          ArticleLanguage.am,
        );
        expect(article.id, 'ethiopian-wolf');
        expect(article.isFallback, isTrue);
      },
    );
  });

  group('onThisDay', () {
    test('returns the event recorded for the date', () async {
      final facts = await repository.onThisDay(
        DateTime(2026, 3),
        ArticleLanguage.en,
      );
      expect(facts.map((f) => f.id), ['adwa-1896']);
      expect(facts.single.text, contains('Battle of Adwa'));
      expect(facts.single.relatedArticleId, 'battle-of-adwa');
    });

    test('returns the text in the requested language', () async {
      final facts = await repository.onThisDay(
        DateTime(2026, 3),
        ArticleLanguage.am,
      );
      expect(facts.single.text, contains('ዓድዋ'));
      expect(facts.single.language, ArticleLanguage.am);
    });

    test('offers an event from another day when none matches', () async {
      final facts = await repository.onThisDay(
        DateTime(2026, 7, 7),
        ArticleLanguage.en,
      );
      expect(facts, hasLength(1));
      expect(facts.single.isOn(DateTime(2026, 7, 7)), isFalse);
    });

    test('returns an empty list when there are no events at all', () async {
      final empty = InMemoryArticlesRepository(
        delay: Duration.zero,
        facts: const [],
      );
      expect(
        await empty.onThisDay(DateTime(2026), ArticleLanguage.en),
        isEmpty,
      );
    });
  });

  group('search', () {
    test('matches the title without regard to case', () async {
      final results = await repository.search('LAKE', ArticleLanguage.en);
      expect(results.map((a) => a.id), ['lake-tana']);
    });

    test('matches the summary too', () async {
      final results = await repository.search('rock-hewn', ArticleLanguage.en);
      expect(results.map((a) => a.id), ['lalibela']);
    });

    test('searches Amharic text when the language is Amharic', () async {
      final results = await repository.search('ጣና', ArticleLanguage.am);
      expect(results.single.title, 'ጣና ሐይቅ');
    });

    test('an article without Amharic is found by its English text', () async {
      final results = await repository.search('wolf', ArticleLanguage.am);
      expect(results.single.id, 'ethiopian-wolf');
      expect(results.single.isFallback, isTrue);
    });

    test('a blank query returns nothing', () async {
      expect(await repository.search('   ', ArticleLanguage.en), isEmpty);
    });

    test('a query that matches nothing returns an empty list', () async {
      expect(await repository.search('zzzz', ArticleLanguage.en), isEmpty);
    });
  });
}
