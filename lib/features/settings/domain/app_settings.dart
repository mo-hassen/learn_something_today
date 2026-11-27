import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/article_language.dart';

part 'app_settings.freezed.dart';

/// The reader's preferences.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ArticleLanguage.am) ArticleLanguage preferredLanguage,

    /// Text size as a multiplier, between [minFontScale] and [maxFontScale].
    @Default(1.0) double fontScale,
    @Default(false) bool dailyNotification,
  }) = _AppSettings;

  const AppSettings._();

  static const minFontScale = 0.8;
  static const maxFontScale = 1.6;

  /// Keeps a text size inside the supported range.
  static double clampFontScale(double value) {
    return value.clamp(minFontScale, maxFontScale);
  }
}
