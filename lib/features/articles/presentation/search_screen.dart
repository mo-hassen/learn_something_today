import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/presentation/state_views.dart';
import '../../../core/router/routes.dart';
import '../data/articles_providers.dart';

/// Search by keyword in the preferred language.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  // The text field's controller is ephemeral UI state; the query itself is
  // app state in a provider, so the results can be derived from it.
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              labelText: 'Search articles',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: ref.read(searchQueryProvider.notifier).set,
          ),
        ),
        Expanded(
          child: query.trim().isEmpty
              ? const EmptyView(
                  icon: Icons.search,
                  message: 'Type a word to search the articles.',
                )
              : AsyncBody(
                  value: results,
                  onRetry: () => ref.invalidate(searchResultsProvider),
                  data: (articles) {
                    if (articles.isEmpty) {
                      return EmptyView(
                        icon: Icons.search_off,
                        message: 'No article matches "${query.trim()}".',
                      );
                    }
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return ListTile(
                          title: Text(article.title),
                          subtitle: Text(
                            article.summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(article.language.nativeName),
                          onTap: () => context.push(
                            Routes.articleFor(
                              article.id,
                              ref.read(preferredLanguageProvider),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
