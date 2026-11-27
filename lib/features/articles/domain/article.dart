import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/article_language.dart';

part 'article.freezed.dart';

/// One article in one language. Immutable; changes go through `copyWith`.
///
/// [id] names the topic and is the same in every language
/// (`lalibela`), so switching language keeps the identity of the article.
@freezed
abstract class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    required ArticleLanguage language,
    required String summary,
    required String fullText,
    required String articleUrl,
    required DateTime updatedAt,
    String? imageUrl,

    /// True when the reader asked for Amharic but only English exists, so
    /// this is the English version shown in its place.
    @Default(false) bool isFallback,
  }) = _Article;

  const Article._();

  static const _wordsPerMinute = 200;

  /// The text split into paragraphs (blank lines separate them).
  List<String> get paragraphs => [
    for (final part in fullText.split(RegExp(r'\n\s*\n')))
      if (part.trim().isNotEmpty) part.trim(),
  ];

  int get wordCount {
    final text = fullText.trim();
    return text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
  }

  /// Rounded up, never less than one minute.
  int get readingMinutes => math.max(1, (wordCount / _wordsPerMinute).ceil());

  /// The first sentence of the text. Amharic sentences end with `።`; a
  /// full stop is not a sentence end there because it appears inside
  /// abbreviations such as `ዓ.ም.`.
  String get firstSentence {
    final text = fullText.trim();
    final end = language == ArticleLanguage.am
        ? RegExp(r'[።?!]')
        : RegExp(r'[.?!](?=\s|$)');
    final match = end.firstMatch(text);
    return match == null ? text : text.substring(0, match.end);
  }
}
