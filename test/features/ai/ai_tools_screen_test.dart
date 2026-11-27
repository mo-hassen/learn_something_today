import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/domain/article_language.dart';
import 'package:learn_something_today/core/router/routes.dart';
import 'package:learn_something_today/features/ai/data/ai_notifiers.dart';
import 'package:learn_something_today/features/ai/data/ai_repository.dart';
import 'package:learn_something_today/features/articles/presentation/article_reader_screen.dart';

import '../../helpers.dart';

void main() {
  final tools = Routes.aiToolsFor('lalibela', ArticleLanguage.en);

  Future<void> accept(WidgetTester tester) async {
    await tester.tap(find.text('I agree'));
    await tester.pumpAndSettle();
  }

  testWidgets('asks for consent before offering anything', (tester) async {
    await pumpApp(tester, initialLocation: tools);

    expect(find.text('Before you start'), findsOneWidget);
    expect(find.textContaining('stays on your device'), findsOneWidget);
    expect(find.text('Simplify'), findsNothing);
    expect(find.text('Quiz me'), findsNothing);
    expect(containerOf(tester).read(aiConsentProvider), isFalse);
  });

  testWidgets('the notice says the text is sent when the service is remote', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: tools, ai: FailingAiRepository());

    expect(find.textContaining('is sent to a test service'), findsOneWidget);
  });

  testWidgets('"Not now" goes back to the article without using the AI', (
    tester,
  ) async {
    await pumpApp(
      tester,
      initialLocation: Routes.articleFor('lalibela', ArticleLanguage.en),
    );
    await tester.tap(find.text('Simplify or take a quiz'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();

    expect(find.byType(ArticleReaderScreen), findsOneWidget);
    expect(containerOf(tester).read(aiConsentProvider), isFalse);
  });

  testWidgets('"Not now" on a direct link goes up to the article', (
    tester,
  ) async {
    // The AI route is nested under the article route, so a direct link
    // still has the article underneath it.
    await pumpApp(tester, initialLocation: tools);

    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();

    expect(find.byType(ArticleReaderScreen), findsOneWidget);
    expect(find.textContaining('eleven medieval churches'), findsOneWidget);
  });

  testWidgets('after consent, Simplify shows the answer with its label', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: tools);
    await accept(tester);

    await tester.tap(find.text('Simplify'));
    await tester.pumpAndSettle();

    expect(find.text('Simplified'), findsOneWidget);
    expect(find.textContaining('Lalibela is a town'), findsOneWidget);
    expect(
      find.text('Demo answer from an offline stub, not from a real AI model.'),
      findsOneWidget,
    );
  });

  testWidgets('Simplify shows a loading indicator while it works', (
    tester,
  ) async {
    await pumpApp(
      tester,
      initialLocation: tools,
      ai: StubAiRepository(delay: const Duration(seconds: 1)),
    );
    await accept(tester);

    await tester.tap(find.text('Simplify'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Simplified'), findsOneWidget);
  });

  testWidgets('a failing AI service shows the error and never crashes', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: tools, ai: FailingAiRepository());
    await accept(tester);

    await tester.tap(find.text('Simplify'));
    await tester.pumpAndSettle();

    expect(find.text('The AI service did not answer.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('Simplified'), findsNothing);
  });

  testWidgets('a quiz: answers are required, then the score is shown', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: tools);
    await accept(tester);

    await tester.tap(find.text('Quiz me'));
    await tester.pumpAndSettle();
    expect(find.text('Quiz'), findsOneWidget);
    expect(find.byType(RadioListTile<int>), findsNWidgets(9));

    final check = find.widgetWithText(FilledButton, 'Check answers');
    expect(tester.widget<FilledButton>(check).onPressed, isNull);

    // The first option of every question: exactly one of the three is right.
    for (final index in [0, 3, 6]) {
      await tester.tap(find.byType(RadioListTile<int>).at(index));
      await tester.pumpAndSettle();
    }
    expect(tester.widget<FilledButton>(check).onPressed, isNotNull);

    await tester.tap(check);
    await tester.pumpAndSettle();

    expect(find.text('You scored 1 out of 3.'), findsOneWidget);
    expect(find.text('Correct'), findsOneWidget);
    expect(find.text('Check answers'), findsNothing);
    final results = containerOf(tester).read(quizResultsProvider);
    expect(results.single.score, 1);
    expect(results.single.articleId, 'lalibela');
    expect(find.text('Your scores on this article: 1/3'), findsOneWidget);
  });

  testWidgets('a new quiz starts with blank answers', (tester) async {
    await pumpApp(tester, initialLocation: tools);
    await accept(tester);
    await tester.tap(find.text('Quiz me'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(RadioListTile<int>).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Quiz me'));
    await tester.pumpAndSettle();

    final check = find.widgetWithText(FilledButton, 'Check answers');
    expect(tester.widget<FilledButton>(check).onPressed, isNull);
  });

  testWidgets('the reader can withdraw consent', (tester) async {
    await pumpApp(tester, initialLocation: tools);
    await accept(tester);
    expect(containerOf(tester).read(aiConsentProvider), isTrue);

    await tester.tap(find.text('Withdraw my consent'));
    await tester.pumpAndSettle();

    expect(find.text('Before you start'), findsOneWidget);
    expect(find.text('Simplify'), findsNothing);
  });

  testWidgets('an unknown article shows "not found"', (tester) async {
    await pumpApp(
      tester,
      initialLocation: Routes.aiToolsFor('nope', ArticleLanguage.en),
    );

    expect(find.text('Article not found.'), findsOneWidget);
  });
}
