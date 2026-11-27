import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result.freezed.dart';

/// The score of one finished quiz. Kept on the device only.
@freezed
abstract class QuizResult with _$QuizResult {
  const factory QuizResult({
    required String id,
    required String articleId,
    required int score,
    required int total,
    required DateTime completedAt,
    String? userId,
  }) = _QuizResult;
}
