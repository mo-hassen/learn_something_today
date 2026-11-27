import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/ai/presentation/ai_tools_screen.dart';
import '../../features/articles/presentation/article_reader_screen.dart';
import '../../features/articles/presentation/home_screen.dart';
import '../../features/articles/presentation/search_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/favourites/presentation/favourites_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../domain/article_language.dart';
import 'app_shell.dart';
import 'routes.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// The router as a provider: tests override it to start on any route.
@riverpod
GoRouter router(Ref ref) => createRouter();

GoRouter createRouter({String initialLocation = Routes.home}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    redirect: (context, state) => state.uri.path == '/' ? Routes.home : null,
    routes: [
      // The four tabs. Each branch keeps its own navigation stack and its
      // widgets alive, so the search text and scroll positions survive a
      // switch of tab.
      StatefulShellRoute(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        // `StatefulShellRoute.indexedStack` turns off the tickers of hidden
        // tabs, and Riverpod 3 then pauses their providers. With Riverpod
        // 3.2.1 a paused provider that is invalidated fails an internal
        // assertion (for example: change the language in Settings while
        // Home is hidden). A plain IndexedStack keeps the hidden tabs
        // active, which is how Riverpod 2 behaved. It still paints and
        // hit-tests only the visible tab.
        navigatorContainerBuilder: (context, navigationShell, children) =>
            IndexedStack(
              index: navigationShell.currentIndex,
              children: children,
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.search,
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.favourites,
                builder: (context, state) => const FavouritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      // Detail routes with parameters, shown above the tabs. The article id
      // is a path parameter and the language a query parameter.
      GoRoute(
        path: Routes.article,
        builder: (context, state) => ArticleReaderScreen(
          articleId: state.pathParameters['id']!,
          language: ArticleLanguage.fromCode(state.uri.queryParameters['lang']),
        ),
        routes: [
          GoRoute(
            path: 'ai',
            builder: (context, state) => AiToolsScreen(
              articleId: state.pathParameters['id']!,
              language: ArticleLanguage.fromCode(
                state.uri.queryParameters['lang'],
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(child: Text('No page at ${state.uri}')),
    ),
  );
}
