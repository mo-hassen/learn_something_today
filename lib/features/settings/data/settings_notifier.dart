import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/article_language.dart';
import '../domain/app_settings.dart';
import 'settings_repository.dart';

part 'settings_notifier.g.dart';

/// The reader's preferences and the operations that change them.
///
/// Every method assigns a new [AppSettings] to `state`, then hands it to
/// the repository to keep.
@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  AppSettings build() => ref.watch(settingsRepositoryProvider).load();

  void setLanguage(ArticleLanguage language) {
    _update(state.copyWith(preferredLanguage: language));
  }

  void setFontScale(double scale) {
    _update(state.copyWith(fontScale: AppSettings.clampFontScale(scale)));
  }

  void setDailyNotification({required bool enabled}) {
    _update(state.copyWith(dailyNotification: enabled));
  }

  void _update(AppSettings next) {
    state = next;
    unawaited(ref.read(settingsRepositoryProvider).save(next));
  }
}
