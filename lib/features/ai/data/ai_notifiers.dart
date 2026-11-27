import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../articles/domain/article.dart';
import '../../auth/data/auth_notifier.dart';
import '../domain/quiz.dart';
import '../domain/quiz_result.dart';
import 'ai_repository.dart';

part 'ai_notifiers.g.dart';

/// Whether the reader agreed to the AI notice. The AI buttons stay hidden
/// until this is true. Kept for the session; Milestone 2 stores it.
@Riverpod(keepAlive: true)
class AiConsent extends _$AiConsent {
  @override
  bool build() => false;

  void grant() => state = true;

  void revoke() => state = false;
}

/// The simplified text of an article. `AsyncData(null)` means nothing was
/// asked for yet; a click on the button calls [simplify].
@riverpod
class Simplify extends _$Simplify {
  @override
  Future<String?> build() async => null;

  Future<void> simplify(Article article) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard<String?>(
      () => ref.read(aiRepositoryProvider).simplify(article),
    );
  }
}

/// The quiz for an article, built on request in the same way.
@riverpod
class QuizMaker extends _$QuizMaker {
  @override
  Future<Quiz?> build() async => null;

  Future<void> generate(Article article) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard<Quiz?>(
      () => ref.read(aiRepositoryProvider).generateQuiz(article),
    );
  }
}

/// Finished quizzes, kept on the device.
@Riverpod(keepAlive: true)
class QuizResults extends _$QuizResults {
  int _nextId = 1;

  @override
  List<QuizResult> build() => const [];

  QuizResult record({
    required String articleId,
    required int score,
    required int total,
    DateTime? now,
  }) {
    final result = QuizResult(
      id: 'q${_nextId++}',
      articleId: articleId,
      score: score,
      total: total,
      completedAt: now ?? DateTime.now(),
      userId: ref.read(authProvider)?.id,
    );
    state = List.unmodifiable([...state, result]);
    return result;
  }
}

/// The earlier results for one article, oldest first.
@riverpod
List<QuizResult> quizResultsFor(Ref ref, String articleId) {
  return [
    for (final result in ref.watch(quizResultsProvider))
      if (result.articleId == articleId) result,
  ];
}
