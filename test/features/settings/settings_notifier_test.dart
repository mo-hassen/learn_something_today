import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/features/articles/data/articles_providers.dart';
import 'package:learn_something_today/features/settings/data/settings_notifier.dart';
import 'package:learn_something_today/features/settings/data/settings_repository.dart';
import 'package:learn_something_today/features/settings/domain/app_settings.dart';

void main() {
  late InMemorySettingsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = InMemorySettingsRepository();
    container = ProviderContainer.test(
      overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
    );
  });

  test('starts with Amharic, normal text size and no reminder', () {
    final settings = container.read(settingsProvider);
    expect(settings.preferredLanguage, ArticleLanguage.am);
    expect(settings.fontScale, 1.0);
    expect(settings.dailyNotification, isFalse);
  });

  test('setLanguage changes the state and the language providers follow', () {
    container.read(settingsProvider.notifier).setLanguage(ArticleLanguage.en);
    expect(
      container.read(settingsProvider).preferredLanguage,
      ArticleLanguage.en,
    );
    expect(container.read(preferredLanguageProvider), ArticleLanguage.en);
  });

  test('every change is handed to the repository', () {
    container.read(settingsProvider.notifier)
      ..setLanguage(ArticleLanguage.en)
      ..setFontScale(1.2)
      ..setDailyNotification(enabled: true);
    final saved = repository.load();
    expect(saved.preferredLanguage, ArticleLanguage.en);
    expect(saved.fontScale, 1.2);
    expect(saved.dailyNotification, isTrue);
  });

  test('setFontScale keeps the value inside the supported range', () {
    final notifier = container.read(settingsProvider.notifier)..setFontScale(5);
    expect(
      container.read(settingsProvider).fontScale,
      AppSettings.maxFontScale,
    );
    notifier.setFontScale(0.1);
    expect(
      container.read(settingsProvider).fontScale,
      AppSettings.minFontScale,
    );
  });

  test('a new container starts from what the repository kept', () {
    repository.save(const AppSettings(preferredLanguage: ArticleLanguage.en));
    final fresh = ProviderContainer.test(
      overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
    );
    expect(fresh.read(settingsProvider).preferredLanguage, ArticleLanguage.en);
  });
}
