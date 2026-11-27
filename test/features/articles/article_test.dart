import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/features/articles/domain/on_this_day_fact.dart';

import '../../helpers.dart';

void main() {
  group('Article', () {
    test('paragraphs splits on blank lines and drops empty ones', () {
      final article = testArticle(fullText: 'One.\n\nTwo.\n\n\n\nThree.\n\n');
      expect(article.paragraphs, ['One.', 'Two.', 'Three.']);
    });

    test('readingMinutes rounds up and is never below one', () {
      expect(testArticle(fullText: '').readingMinutes, 1);
      expect(
        testArticle(fullText: List.filled(200, 'w').join(' ')).readingMinutes,
        1,
      );
      expect(
        testArticle(fullText: List.filled(201, 'w').join(' ')).readingMinutes,
        2,
      );
      expect(
        testArticle(fullText: List.filled(401, 'w').join(' ')).readingMinutes,
        3,
      );
    });

    test('firstSentence stops at the first full stop followed by a space', () {
      final article = testArticle(
        fullText: 'It rose 1.5 metres. Then it fell.',
      );
      expect(article.firstSentence, 'It rose 1.5 metres.');
    });

    test('firstSentence returns the whole text when there is no end mark', () {
      expect(testArticle(fullText: 'No end mark').firstSentence, 'No end mark');
    });

    test('Amharic sentences end at the Ethiopic full stop, not at "ዓ.ም."', () {
      final article = testArticle(
        language: ArticleLanguage.am,
        fullText: 'በ1888 ዓ.ም. ተካሄደ። ሁለተኛ ዓረፍተ ነገር።',
      );
      expect(article.firstSentence, 'በ1888 ዓ.ም. ተካሄደ።');
    });

    test('copyWith makes a new article and leaves the old one unchanged', () {
      final original = testArticle();
      final changed = original.copyWith(title: 'Other');
      expect(original.title, 'Test article');
      expect(changed.title, 'Other');
      expect(changed.id, original.id);
    });
  });

  group('OnThisDayFact', () {
    const fact = OnThisDayFact(
      id: 'f',
      year: 1896,
      month: 3,
      day: 1,
      text: 'x',
      language: ArticleLanguage.en,
    );

    test('isOn compares day and month, not the year', () {
      expect(fact.isOn(DateTime(2026, 3, 1)), isTrue);
      expect(fact.isOn(DateTime(2026, 3, 2)), isFalse);
      expect(fact.isOn(DateTime(2026, 4, 1)), isFalse);
    });

    test('dayLabel names the month', () {
      expect(fact.dayLabel, '1 March');
    });
  });

  group('ArticleLanguage', () {
    test('fromCode reads a URL value and defaults to Amharic', () {
      expect(ArticleLanguage.fromCode('en'), ArticleLanguage.en);
      expect(ArticleLanguage.fromCode('am'), ArticleLanguage.am);
      expect(ArticleLanguage.fromCode(null), ArticleLanguage.am);
      expect(ArticleLanguage.fromCode('xx'), ArticleLanguage.am);
    });

    test('other returns the opposite language', () {
      expect(ArticleLanguage.am.other, ArticleLanguage.en);
      expect(ArticleLanguage.en.other, ArticleLanguage.am);
    });
  });
}
