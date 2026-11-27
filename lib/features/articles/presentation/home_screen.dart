import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/presentation/state_views.dart';
import '../../../core/router/routes.dart';
import '../../../core/time/now_provider.dart';
import '../../settings/data/settings_notifier.dart';
import '../data/articles_providers.dart';
import '../domain/on_this_day_fact.dart';
import 'widgets/article_card.dart';
import 'widgets/language_toggle.dart';

/// The first tab: today's featured article and the "On This Day" events.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref
      ..invalidate(dailyArticleProvider)
      ..invalidate(onThisDayProvider);
    try {
      await ref.read(dailyArticleProvider.future);
    } catch (_) {
      // The card shows the error; the refresh indicator just stops.
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(preferredLanguageProvider);
    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: ListView(
        // Pull-to-refresh needs a list that can always be pulled, even when
        // the content is shorter than the screen.
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: LanguageToggle(
              selected: language,
              onChanged: ref.read(settingsProvider.notifier).setLanguage,
            ),
          ),
          const SizedBox(height: 16),
          const _DailyArticleSection(),
          const SizedBox(height: 24),
          Text('On this day', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const _OnThisDaySection(),
        ],
      ),
    );
  }
}

class _DailyArticleSection extends ConsumerWidget {
  const _DailyArticleSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(dailyArticleProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: article.hasValue ? 0 : 24),
      child: AsyncBody(
        value: article,
        onRetry: () => ref.invalidate(dailyArticleProvider),
        data: (article) => ArticleCard(
          heading: 'Article of the day',
          article: article,
          onTap: () => context.push(
            Routes.articleFor(article.id, ref.read(preferredLanguageProvider)),
          ),
        ),
      ),
    );
  }
}

class _OnThisDaySection extends ConsumerWidget {
  const _OnThisDaySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facts = ref.watch(onThisDayProvider);
    final today = ref.watch(nowProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: facts.hasValue ? 0 : 24),
      child: AsyncBody(
        value: facts,
        onRetry: () => ref.invalidate(onThisDayProvider),
        data: (facts) {
          if (facts.isEmpty) {
            return const EmptyView(
              icon: Icons.history,
              message: 'No events are recorded for today.',
            );
          }
          return Column(
            children: [
              for (final fact in facts) _FactTile(fact: fact, today: today),
            ],
          );
        },
      ),
    );
  }
}

class _FactTile extends ConsumerWidget {
  const _FactTile({required this.fact, required this.today});

  final OnThisDayFact fact;
  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final related = fact.relatedArticleId;
    // When nothing happened on today's date the repository returns an
    // event from another day; say so instead of implying it was today.
    final title = fact.isOn(today)
        ? '${fact.year}'
        : '${fact.year} · ${fact.dayLabel}';
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(fact.text),
        trailing: related == null ? null : const Icon(Icons.chevron_right),
        onTap: related == null
            ? null
            : () => context.push(
                Routes.articleFor(related, ref.read(preferredLanguageProvider)),
              ),
      ),
    );
  }
}
