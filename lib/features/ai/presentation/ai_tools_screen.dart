import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/article_language.dart';
import '../../../core/presentation/state_views.dart';
import '../../../core/router/navigation.dart';
import '../../articles/data/articles_providers.dart';
import '../../articles/domain/article.dart';
import '../data/ai_notifiers.dart';
import '../data/ai_repository.dart';
import '../domain/quiz.dart';

/// Simplify an article or take a quiz about it. Nothing is asked of the
/// AI service until the reader has read and accepted the notice.
class AiToolsScreen extends ConsumerWidget {
  const AiToolsScreen({
    required this.articleId,
    required this.language,
    super.key,
  });

  final String articleId;
  final ArticleLanguage language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articleProvider(articleId, language));
    return Scaffold(
      appBar: AppBar(title: const Text('AI tools')),
      body: AsyncBody(
        value: article,
        onRetry: () => ref.invalidate(articleProvider(articleId, language)),
        data: (article) => _AiToolsBody(article: article),
      ),
    );
  }
}

class _AiToolsBody extends ConsumerWidget {
  const _AiToolsBody({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consented = ref.watch(aiConsentProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        if (!consented)
          const _ConsentCard()
        else ...[
          _Actions(article: article),
          const SizedBox(height: 16),
          _SimplifyResult(article: article),
          _QuizResult(article: article),
          const SizedBox(height: 16),
          TextButton(
            onPressed: ref.read(aiConsentProvider.notifier).revoke,
            child: const Text('Withdraw my consent'),
          ),
        ],
      ],
    );
  }
}

/// The notice the reader must accept before any AI feature runs.
class _ConsentCard extends ConsumerWidget {
  const _ConsentCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ai = ref.watch(aiRepositoryProvider);
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.privacy_tip_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Before you start',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              ai.sendsDataOffDevice
                  ? 'The text of this article is sent to ${ai.providerName} '
                        'to write the answer. Nothing else is sent: no '
                        'name, e-mail or device details.'
                  : 'This version uses ${ai.providerName}. The article text '
                        'stays on your device.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Answers can be wrong. Check important facts in the article. '
              'You can say no and keep reading.',
            ),
            const SizedBox(height: 16),
            // OverflowBar puts the buttons in a column when a row does not fit.
            OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8,
              overflowAlignment: OverflowBarAlignment.end,
              children: [
                TextButton(
                  onPressed: context.popOrGoHome,
                  child: const Text('Not now'),
                ),
                FilledButton(
                  onPressed: ref.read(aiConsentProvider.notifier).grant,
                  child: const Text('I agree'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Actions extends ConsumerWidget {
  const _Actions({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FilledButton.icon(
          onPressed: () =>
              ref.read(simplifyProvider.notifier).simplify(article),
          icon: const Icon(Icons.short_text),
          label: const Text('Simplify'),
        ),
        FilledButton.tonalIcon(
          onPressed: () =>
              ref.read(quizMakerProvider.notifier).generate(article),
          icon: const Icon(Icons.quiz_outlined),
          label: const Text('Quiz me'),
        ),
      ],
    );
  }
}

/// The label that says what produced an answer.
class _Disclosure extends ConsumerWidget {
  const _Disclosure();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    // Not a Chip: a chip keeps its label on one line, and this label is
    // long enough to wrap on a small phone.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              ref.watch(aiRepositoryProvider).disclosure,
              style: theme.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _SimplifyResult extends ConsumerWidget {
  const _SimplifyResult({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(simplifyProvider);
    return result.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: LoadingView(),
      ),
      error: (error, stack) => ErrorView(
        error: error,
        onRetry: () => ref.read(simplifyProvider.notifier).simplify(article),
      ),
      data: (text) {
        if (text == null) return const SizedBox.shrink();
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Simplified',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(text),
                const SizedBox(height: 8),
                const _Disclosure(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuizResult extends ConsumerWidget {
  const _QuizResult({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(quizMakerProvider);
    return result.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: LoadingView(),
      ),
      error: (error, stack) => ErrorView(
        error: error,
        onRetry: () => ref.read(quizMakerProvider.notifier).generate(article),
      ),
      data: (quiz) {
        if (quiz == null) return const SizedBox.shrink();
        return _QuizView(key: ObjectKey(quiz), quiz: quiz);
      },
    );
  }
}

/// Shows the questions and scores the answers. The picked options live in
/// this widget because they matter only until the quiz is checked; the
/// score is then recorded in a provider.
class _QuizView extends ConsumerStatefulWidget {
  const _QuizView({required this.quiz, super.key});

  final Quiz quiz;

  @override
  ConsumerState<_QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<_QuizView> {
  late final List<int?> _answers = List.filled(widget.quiz.length, null);
  int? _score;

  bool get _complete => _answers.every((a) => a != null);

  void _check() {
    final score = widget.quiz.score(_answers);
    ref
        .read(quizResultsProvider.notifier)
        .record(
          articleId: widget.quiz.articleId,
          score: score,
          total: widget.quiz.length,
        );
    setState(() => _score = score);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quiz = widget.quiz;
    final checked = _score != null;
    final earlier = ref.watch(quizResultsForProvider(quiz.articleId));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quiz', style: theme.textTheme.titleMedium),
            const _Disclosure(),
            for (var i = 0; i < quiz.length; i++) ...[
              const SizedBox(height: 16),
              Text(
                '${i + 1}. ${quiz.questions[i].question}',
                style: theme.textTheme.titleSmall,
              ),
              RadioGroup<int>(
                groupValue: _answers[i],
                onChanged: (value) {
                  if (!checked) setState(() => _answers[i] = value);
                },
                child: Column(
                  children: [
                    for (var j = 0; j < quiz.questions[i].options.length; j++)
                      RadioListTile<int>(
                        value: j,
                        enabled: !checked,
                        title: Text(quiz.questions[i].options[j]),
                      ),
                  ],
                ),
              ),
              if (checked)
                Text(
                  _answers[i] == quiz.questions[i].correctIndex
                      ? 'Correct'
                      : 'Answer: '
                            '${quiz.questions[i].options[quiz.questions[i].correctIndex]}',
                  style: TextStyle(
                    color: _answers[i] == quiz.questions[i].correctIndex
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error,
                  ),
                ),
            ],
            const SizedBox(height: 16),
            if (checked)
              Text(
                'You scored $_score out of ${quiz.length}.',
                style: theme.textTheme.titleMedium,
              )
            else
              FilledButton(
                onPressed: _complete ? _check : null,
                child: const Text('Check answers'),
              ),
            if (earlier.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Your scores on this article: '
                '${earlier.map((r) => '${r.score}/${r.total}').join(', ')}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
