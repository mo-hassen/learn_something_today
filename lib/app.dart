import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/data/settings_notifier.dart';

/// Root widget of Learn Something Today.
///
/// Milestone 1: every screen, navigation with go_router, and app state in
/// Riverpod providers. The data is in memory; Milestone 2 adds the
/// database, the Wikipedia REST API and Firebase.
class LearnSomethingTodayApp extends ConsumerWidget {
  const LearnSomethingTodayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final fontScale = ref.watch(settingsProvider.select((s) => s.fontScale));
    return MaterialApp.router(
      title: 'Learn Something Today',
      theme: AppTheme.light,
      routerConfig: router,
      // The text size chosen in the settings applies to every screen, on
      // top of the size the reader set for the whole phone.
      builder: (context, child) {
        final system = MediaQuery.textScalerOf(context).scale(1);
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(system * fontScale)),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
