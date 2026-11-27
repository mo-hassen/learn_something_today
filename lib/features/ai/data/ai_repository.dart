import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/article_language.dart';
import '../../articles/domain/article.dart';
import '../domain/quiz.dart';

part 'ai_repository.g.dart';

/// What the app needs from an AI service. The screens depend on this
/// interface only. Milestone 2 and the final version add a real model
/// behind it; until then [StubAiRepository] answers from the article text.
abstract interface class AiRepository {
  /// Who receives the article text, shown in the consent notice.
  String get providerName;

  /// Whether the article text leaves the device. The consent notice says so.
  bool get sendsDataOffDevice;

  /// The label shown next to every answer, so the reader always knows
  /// what produced it.
  String get disclosure;

  /// A shorter, plainer version of [article].
  Future<String> simplify(Article article);

  /// A short multiple-choice quiz about [article].
  Future<Quiz> generateQuiz(Article article);
}

/// An offline stand-in. It does not call any AI model: it builds its
/// answers from the article text, so the screens and the consent flow can
/// be built and tested before a real service is chosen.
class StubAiRepository implements AiRepository {
  StubAiRepository({this.delay = const Duration(milliseconds: 600)});

  final Duration delay;

  @override
  String get providerName => 'the offline demo stub';

  @override
  bool get sendsDataOffDevice => false;

  @override
  String get disclosure =>
      'Demo answer from an offline stub, not from a real AI model.';

  @override
  Future<String> simplify(Article article) async {
    await Future<void>.delayed(delay);
    final first = article.firstSentence;
    return first == article.summary
        ? article.summary
        : '${article.summary} $first';
  }

  @override
  Future<Quiz> generateQuiz(Article article) async {
    await Future<void>.delayed(delay);
    final copy = _QuizCopy.of(article.language);
    final size = article.title.length;
    return Quiz(
      articleId: article.id,
      questions: List.unmodifiable([
        _choose(
          copy.titleQuestion,
          correct: article.title,
          wrong: copy.wrongTitles,
          position: size % 3,
        ),
        _choose(
          copy.sentenceQuestion,
          correct: article.firstSentence,
          wrong: copy.wrongSentences,
          position: (size + 1) % 3,
        ),
        _choose(
          copy.paragraphQuestion,
          correct: '${article.paragraphs.length}',
          wrong: [
            '${article.paragraphs.length + 1}',
            '${article.paragraphs.length + 2}',
          ],
          position: (size + 2) % 3,
        ),
      ]),
    );
  }

  /// Puts [correct] among the [wrong] options at [position].
  QuizQuestion _choose(
    String question, {
    required String correct,
    required List<String> wrong,
    required int position,
  }) {
    final options = [...wrong]..insert(position, correct);
    return QuizQuestion(
      question: question,
      options: List.unmodifiable(options),
      correctIndex: position,
    );
  }
}

/// The fixed sentences of the stub quiz, in each language.
class _QuizCopy {
  const _QuizCopy({
    required this.titleQuestion,
    required this.wrongTitles,
    required this.sentenceQuestion,
    required this.wrongSentences,
    required this.paragraphQuestion,
  });

  final String titleQuestion;
  final List<String> wrongTitles;
  final String sentenceQuestion;
  final List<String> wrongSentences;
  final String paragraphQuestion;

  static _QuizCopy of(ArticleLanguage language) {
    return switch (language) {
      ArticleLanguage.am => _am,
      ArticleLanguage.en => _en,
    };
  }

  static const _en = _QuizCopy(
    titleQuestion: 'What is the title of this article?',
    wrongTitles: ['A recipe for bread', 'A football result'],
    sentenceQuestion: 'Which of these sentences is in the article?',
    wrongSentences: [
      'This text is about space travel.',
      'This text is about football.',
    ],
    paragraphQuestion: 'How many paragraphs does the article have?',
  );

  static const _am = _QuizCopy(
    titleQuestion: 'የዚህ ጽሑፍ ርዕስ ምንድን ነው?',
    wrongTitles: ['የምግብ አሰራር', 'የእግር ኳስ ውጤት'],
    sentenceQuestion: 'ከእነዚህ ዓረፍተ ነገሮች ውስጥ በጽሑፉ ውስጥ የሚገኘው የትኛው ነው?',
    wrongSentences: ['ይህ ጽሑፍ ስለ ጠፈር ጉዞ ነው።', 'ይህ ጽሑፍ ስለ እግር ኳስ ነው።'],
    paragraphQuestion: 'ጽሑፉ ስንት አንቀጾች አሉት?',
  );
}

@Riverpod(keepAlive: true)
AiRepository aiRepository(Ref ref) => StubAiRepository();
