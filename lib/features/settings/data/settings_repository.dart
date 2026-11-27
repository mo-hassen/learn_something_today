import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_settings.dart';

part 'settings_repository.g.dart';

/// Where the preferences are kept. Milestone 2 adds an implementation on
/// `shared_preferences`; the notifier above it does not change.
abstract interface class SettingsRepository {
  AppSettings load();
  Future<void> save(AppSettings settings);
}

/// Keeps the settings in memory: they are lost when the app closes.
class InMemorySettingsRepository implements SettingsRepository {
  InMemorySettingsRepository([this._settings = const AppSettings()]);

  AppSettings _settings;

  @override
  AppSettings load() => _settings;

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => InMemorySettingsRepository();
