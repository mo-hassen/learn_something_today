import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/article_language.dart';

part 'on_this_day_fact.freezed.dart';

const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// A historical event that happened on a given day of the year.
@freezed
abstract class OnThisDayFact with _$OnThisDayFact {
  const factory OnThisDayFact({
    required String id,
    required int year,
    required int month,
    required int day,
    required String text,
    required ArticleLanguage language,

    /// The article that tells more, when there is one.
    String? relatedArticleId,
  }) = _OnThisDayFact;

  const OnThisDayFact._();

  /// Whether this event happened on the same day and month as [date].
  bool isOn(DateTime date) => date.month == month && date.day == day;

  /// For example `1 March`.
  String get dayLabel => '$day ${_monthNames[month - 1]}';
}
