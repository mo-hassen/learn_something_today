import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';

/// One multiple-choice question.
///
/// `makeCollectionsUnmodifiable: false`: with freezed 3.2.5 the default
/// generates a constructor that the Dart 3.13 compiler rejects. The lists
/// are built with `List.unmodifiable` by the code that creates them.
@Freezed(makeCollectionsUnmodifiable: false)
abstract class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String question,
    required List<String> options,
    required int correctIndex,
  }) = _QuizQuestion;
}

/// A short quiz about one article. See [QuizQuestion] for the annotation.
@Freezed(makeCollectionsUnmodifiable: false)
abstract class Quiz with _$Quiz {
  const factory Quiz({
    required String articleId,
    required List<QuizQuestion> questions,
  }) = _Quiz;

  const Quiz._();

  int get length => questions.length;

  /// How many of [answers] are right. `answers[i]` is the option the
  /// reader picked for question `i`, or null when it was left blank; a
  /// blank answer scores nothing.
  int score(List<int?> answers) {
    var correct = 0;
    for (var i = 0; i < questions.length && i < answers.length; i++) {
      if (answers[i] == questions[i].correctIndex) correct++;
    }
    return correct;
  }
}
