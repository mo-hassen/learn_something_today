import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/core/router/routes.dart';
import 'package:learn_something_today/features/settings/data/settings_repository.dart';
import 'package:learn_something_today/features/settings/domain/app_settings.dart';

import '../helpers.dart';

/// A layout overflow is reported as an exception, which fails the test. The
/// course asks for no overflow at 360 px wide and at 900 px wide; the first
/// group also uses the largest text size.
void main() {
  const narrow = Size(360, 640);
  const wide = Size(900, 700);

  for (final (name, size, scale) in [
    ('360 px wide, normal text', narrow, 1.0),
    ('360 px wide, largest text', narrow, AppSettings.maxFontScale),
    ('900 px wide, normal text', wide, 1.0),
  ]) {
    group(name, () {
      Future<void> open(WidgetTester tester, String location) {
        return pumpApp(
          tester,
          initialLocation: location,
          size: size,
          settings: InMemorySettingsRepository(AppSettings(fontScale: scale)),
        );
      }

      testWidgets('the four tabs', (tester) async {
        await open(tester, Routes.home);
        for (final tab in ['Search', 'Favourites', 'Settings', 'Home']) {
          await tapTab(tester, tab);
          expect(tester.takeException(), isNull, reason: tab);
        }
      });

      testWidgets('the reader, in Amharic and in English', (tester) async {
        await open(tester, Routes.articleFor('lalibela', ArticleLanguage.am));
        expect(tester.takeException(), isNull);
        await tester.tap(find.text('English'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });

      testWidgets('the reader with the English fallback notice', (
        tester,
      ) async {
        await open(
          tester,
          Routes.articleFor('ethiopian-wolf', ArticleLanguage.am),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('the AI tools with a quiz on screen', (tester) async {
        await open(tester, Routes.aiToolsFor('lalibela', ArticleLanguage.en));
        expect(tester.takeException(), isNull);
        // With large text the buttons are below the fold: scroll first.
        await tester.ensureVisible(find.text('I agree'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('I agree'));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Quiz me'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Quiz me'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });

      testWidgets('the sign-in form, including its error messages', (
        tester,
      ) async {
        await open(tester, Routes.signIn);
        await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    });
  }
}
