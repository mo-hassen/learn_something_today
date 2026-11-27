import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/presentation/state_views.dart';
import '../../../core/router/routes.dart';
import '../../auth/data/auth_notifier.dart';
import '../data/favourites_notifier.dart';
import '../domain/favourite.dart';

/// The articles the reader saved, newest first.
class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(sortedFavouritesProvider);
    return AsyncBody(
      value: favourites,
      onRetry: () => ref.invalidate(favouritesProvider),
      // The notice scrolls with the list, so it never squeezes the list
      // out on a small screen or with a large text size.
      data: (items) => ListView.builder(
        itemCount: items.isEmpty ? 2 : items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return const _SyncNotice();
          if (items.isEmpty) {
            return const EmptyView(
              icon: Icons.bookmark_border,
              message:
                  'No saved articles yet. Tap the bookmark on an '
                  'article to keep it here.',
            );
          }
          return _FavouriteTile(favourite: items[index - 1]);
        },
      ),
    );
  }
}

class _FavouriteTile extends ConsumerWidget {
  const _FavouriteTile({required this.favourite});

  final Favourite favourite;

  static String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = favourite.article;
    final saved = favourite.savedAt;
    return Dismissible(
      key: ValueKey(favourite.id),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: Theme.of(context).colorScheme.errorContainer,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.delete),
          ),
        ),
      ),
      onDismissed: (_) =>
          ref.read(favouritesProvider.notifier).remove(favourite.articleId),
      child: ListTile(
        leading: const Icon(Icons.bookmark),
        title: Text(article.title),
        subtitle: Text(
          '${article.language.nativeName} · saved '
          '${saved.year}-${_two(saved.month)}-${_two(saved.day)}',
        ),
        trailing: IconButton(
          tooltip: 'Remove from favourites',
          icon: const Icon(Icons.delete_outline),
          onPressed: () =>
              ref.read(favouritesProvider.notifier).remove(favourite.articleId),
        ),
        onTap: () =>
            context.push(Routes.articleFor(article.id, article.language)),
      ),
    );
  }
}

/// Explains syncing: a guest is invited to sign in, a signed-in reader is
/// told what is still to come.
class _SyncNotice extends ConsumerWidget {
  const _SyncNotice();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return Card(
      margin: const EdgeInsets.all(16),
      child: ListTile(
        leading: const Icon(Icons.cloud_sync_outlined),
        title: Text(
          user == null
              ? 'Sign in to sync your favourites'
              : 'Signed in as ${user.email}',
        ),
        subtitle: const Text(
          'Syncing between your devices is added in the next version.',
        ),
        trailing: user == null
            ? TextButton(
                onPressed: () => context.push(Routes.signIn),
                child: const Text('Sign in'),
              )
            : null,
      ),
    );
  }
}
