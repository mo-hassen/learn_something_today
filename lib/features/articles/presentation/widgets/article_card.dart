import 'package:flutter/material.dart';

import '../../domain/article.dart';
import 'fallback_notice.dart';

/// A tappable summary of an article, used on the home screen.
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    required this.article,
    required this.onTap,
    this.heading,
    super.key,
  });

  final Article article;
  final VoidCallback onTap;

  /// A small label above the title, such as "Article of the day".
  final String? heading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (heading != null)
                Text(
                  heading!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(label: Text(article.language.nativeName)),
                  Chip(label: Text('${article.readingMinutes} min read')),
                ],
              ),
              const SizedBox(height: 8),
              Text(article.title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(article.summary),
              if (article.isFallback) ...[
                const SizedBox(height: 12),
                const FallbackNotice(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
