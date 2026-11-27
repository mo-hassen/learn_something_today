import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/core/network/app_exception.dart';
import 'package:learn_something_today/features/ai/data/ai_notifiers.dart';
import 'package:learn_something_today/features/ai/data/ai_repository.dart';
import 'package:learn_something_today/features/ai/domain/quiz.dart';

import '../../helpers.dart';

void main() {
  group('Quiz.score', () {
    const quiz = Quiz(
      articleId: 'a',
      questions: [
        QuizQuestion(question: 'Q1', options: ['x', 'y', 'z'], correctIndex: 0),
        QuizQuestion(question: 'Q2', options: ['x', 'y', 'z'], correctIndex: 2),
        QuizQuestion(question: 'Q3', options: ['x', 'y', 'z'], correctIndex: 1),
      ],
    );

    test('counts the right answers', () {
      expect(quiz.score([0, 2, 1]), 3);
      expect(quiz.score([0, 0, 0]), 1);
      expect(quiz.score([1, 2, 2]), 1);
      expect(quiz.score([1, 1, 2]), 0);
    });

    test('a blank answer scores nothing', () {
      expect(quiz.score([null, null, null]), 0);
      expect(quiz.score([0, null, 1]), 2);
    });

    test('ignores answers beyond the last question', () {
      expect(quiz.score([0, 2, 1, 1, 1]), 3);
    });

    test('length is the number of questions', () {
      expect(quiz.length, 3);
    });
  });

  group('StubAiRepository', () {
    final repository = StubAiRepository(delay: Duration.zero);

    test('does not send the article anywhere', () {
      expect(repository.sendsDataOffDevice, isFalse);
      expect(repository.disclosure, contains('not from a real AI model'));
    });

    test(
      'simplify adds the first sentence when it differs from the summary',
      () async {
        final text = await repository.simplify(testArticle());
        expect(text, 'A summary. First paragraph.');
      },
    );

    test(
      'simplify returns only the summary when it repeats the first sentence',
      () async {
        final article = testArticle(fullText: 'A summary. More text.');
        expect(await repository.simplify(article), 'A summary.');
      },
    );

    test('generateQuiz asks three questions about the article', () async {
      final article = testArticle(title: 'Lake Tana');
      final quiz = await repository.generateQuiz(article);
      expect(quiz.articleId, article.id);
      expect(quiz.length, 3);
      for (final question in quiz.questions) {
        expect(question.options, hasLength(3));
        expect(question.options.toSet(), hasLength(3));
        expect(question.correctIndex, inInclusiveRange(0, 2));
      }
    });

    test('the right options are the true facts about the article', () async {
      final article = testArticle(title: 'Lake Tana');
      final quiz = await repository.generateQuiz(article);
      String right(int i) =>
          quiz.questions[i].options[quiz.questions[i].correctIndex];
      expect(right(0), 'Lake Tana');
      expect(right(1), 'First paragraph.');
      expect(right(2), '2');
    });

    test('picking the first option every time scores exactly one', () async {
      // The right answers sit at three different positions, so any single
      // fixed position is right once.
      for (final title in ['A', 'Lake Tana', 'Addis Ababa', 'Coffee']) {
        final quiz = await repository.generateQuiz(testArticle(title: title));
        expect(quiz.score([0, 0, 0]), 1, reason: title);
      }
    });

    test('the quiz is written in the language of the article', () async {
      final quiz = await repository.generateQuiz(
        testArticle(language: ArticleLanguage.am, fullText: 'አንድ።\n\nሁለት።'),
      );
      expect(quiz.questions.first.question, contains('ርዕስ'));
    });
  });

  group('AI notifiers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer.test(
        overrides: [
          aiRepositoryProvider.overrideWithValue(
            StubAiRepository(delay: Duration.zero),
          ),
        ],
      );
    });

    test('consent is off until the reader agrees, and can be withdrawn', () {
      expect(container.read(aiConsentProvider), isFalse);
      container.read(aiConsentProvider.notifier).grant();
      expect(container.read(aiConsentProvider), isTrue);
      container.read(aiConsentProvider.notifier).revoke();
      expect(container.read(aiConsentProvider), isFalse);
    });

    test('nothing is asked of the AI until a button is pressed', () async {
      container
        ..listen(simplifyProvider, (_, _) {})
        ..listen(quizMakerProvider, (_, _) {});
      expect(await container.read(simplifyProvider.future), isNull);
      expect(await container.read(quizMakerProvider.future), isNull);
    });

    test('simplify moves from loading to the answer', () async {
      container.listen(simplifyProvider, (_, _) {});
      final future = container
          .read(simplifyProvider.notifier)
          .simplify(testArticle());
      expect(container.read(simplifyProvider).isLoading, isTrue);
      await future;
      expect(container.read(simplifyProvider).value, contains('A summary.'));
    });

    test('a failing AI service ends in an error state, not a crash', () async {
      final failing = ProviderContainer.test(
        overrides: [
          aiRepositoryProvider.overrideWithValue(FailingAiRepository()),
        ],
      )..listen(simplifyProvider, (_, _) {});
      await failing.read(simplifyProvider.notifier).simplify(testArticle());
      final state = failing.read(simplifyProvider);
      expect(state.hasError, isTrue);
      expect(state.error, isA<NetworkException>());
    });

    test('generate builds a quiz', () async {
      container.listen(quizMakerProvider, (_, _) {});
      await container.read(quizMakerProvider.notifier).generate(testArticle());
      expect(container.read(quizMakerProvider).value?.length, 3);
    });

    test('quiz results are recorded with a running id', () {
      final results = container.read(quizResultsProvider.notifier);
      final first = results.record(articleId: 'a', score: 2, total: 3);
      final second = results.record(articleId: 'b', score: 1, total: 3);
      expect(first.id, 'q1');
      expect(second.id, 'q2');
      expect(first.userId, isNull);
      expect(container.read(quizResultsProvider), [first, second]);
    });

    test('quizResultsFor returns only the results of one article', () {
      container.read(quizResultsProvider.notifier)
        ..record(articleId: 'a', score: 2, total: 3)
        ..record(articleId: 'b', score: 1, total: 3)
        ..record(articleId: 'a', score: 3, total: 3);
      final forA = container.read(quizResultsForProvider('a'));
      expect(forA.map((r) => r.score), [2, 3]);
    });
  });
}
