import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/article_language.dart';
import '../../../core/presentation/state_views.dart';
import '../../../core/router/routes.dart';
import '../../favourites/data/favourites_notifier.dart';
import '../data/articles_providers.dart';
import '../data/reading_aloud_notifier.dart';
import '../domain/article.dart';
import 'widgets/fallback_notice.dart';
import 'widgets/language_toggle.dart';

/// The full text of one article, in the language named by the route.
class ArticleReaderScreen extends ConsumerWidget {
  const ArticleReaderScreen({
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
      appBar: AppBar(
        title: Text(
          article.value?.title ?? 'Article',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (article.value case final loaded?) ...[
            const _ReadAloudButton(),
            const _ShareButton(),
            _BookmarkButton(article: loaded),
          ],
        ],
      ),
      body: AsyncBody(
        value: article,
        onRetry: () => ref.invalidate(articleProvider(articleId, language)),
        data: (article) => _ArticleBody(article: article, requested: language),
      ),
      bottomNavigationBar: article.hasValue
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FilledButton.tonalIcon(
                  onPressed: () =>
                      context.push(Routes.aiToolsFor(articleId, language)),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Simplify or take a quiz'),
                ),
              ),
            )
          : null,
    );
  }
}

class _ArticleBody extends ConsumerWidget {
  const _ArticleBody({required this.article, required this.requested});

  final Article article;

  /// The language the reader asked for, which differs from
  /// `article.language` when the English fallback is shown.
  final ArticleLanguage requested;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final readingAloud = ref.watch(readingAloudProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: LanguageToggle(
            selected: requested,
            onChanged: (language) =>
                context.replace(Routes.articleFor(article.id, language)),
          ),
        ),
        const SizedBox(height: 16),
        if (article.isFallback) ...[
          const FallbackNotice(),
          const SizedBox(height: 16),
        ],
        Text(article.title, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(
          '${article.readingMinutes} min read',
          style: theme.textTheme.labelLarge,
        ),
        if (readingAloud) ...[
          const SizedBox(height: 12),
          const _ReadingAloudBanner(),
        ],
        const SizedBox(height: 16),
        for (final paragraph in article.paragraphs) ...[
          Text(
            paragraph,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 16),
        ],
        Text('Source: ${article.articleUrl}', style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _ReadAloudButton extends ConsumerWidget {
  const _ReadAloudButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reading = ref.watch(readingAloudProvider);
    return IconButton(
      tooltip: reading ? 'Stop reading aloud' : 'Read aloud',
      icon: Icon(reading ? Icons.stop_circle_outlined : Icons.volume_up),
      onPressed: ref.read(readingAloudProvider.notifier).toggle,
    );
  }
}

class _ReadingAloudBanner extends StatelessWidget {
  const _ReadingAloudBanner();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.graphic_eq),
        title: Text('Reading aloud'),
        subtitle: Text('Demo only: real speech is added in the next version.'),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Share',
      icon: const Icon(Icons.share),
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sharing is added in the next version.')),
      ),
    );
  }
}

class _BookmarkButton extends ConsumerWidget {
  const _BookmarkButton({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(isFavouriteProvider(article.id));
    return IconButton(
      tooltip: saved ? 'Remove from favourites' : 'Save to favourites',
      icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        await ref.read(favouritesProvider.notifier).toggle(article);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                saved ? 'Removed from favourites' : 'Saved to favourites',
              ),
            ),
          );
      },
    );
  }
}
