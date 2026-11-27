import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../articles/presentation/widgets/language_toggle.dart';
import '../../auth/data/auth_notifier.dart';
import '../data/settings_notifier.dart';
import '../domain/app_settings.dart';

/// Language, text size, notifications and the account.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Language', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: LanguageToggle(
            selected: settings.preferredLanguage,
            onChanged: notifier.setLanguage,
          ),
        ),
        const SizedBox(height: 24),
        Text('Text size', style: theme.textTheme.titleMedium),
        Slider(
          value: settings.fontScale,
          min: AppSettings.minFontScale,
          max: AppSettings.maxFontScale,
          divisions: 8,
          label: '${(settings.fontScale * 100).round()}%',
          semanticFormatterCallback: (value) =>
              'Text size ${(value * 100).round()} percent',
          onChanged: notifier.setFontScale,
        ),
        const Text('Learn something new every day.'),
        const SizedBox(height: 16),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Daily article reminder'),
          subtitle: const Text('Reminders are added in the final version.'),
          value: settings.dailyNotification,
          onChanged: (enabled) =>
              notifier.setDailyNotification(enabled: enabled),
        ),
        const Divider(),
        const _AccountTile(),
      ],
    );
  }
}

class _AccountTile extends ConsumerWidget {
  const _AccountTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.account_circle_outlined),
        title: const Text('You are not signed in'),
        subtitle: const Text('Sign in to sync your favourites.'),
        trailing: FilledButton(
          onPressed: () => context.push(Routes.signIn),
          child: const Text('Sign in'),
        ),
      );
    }
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.account_circle),
      title: Text(user.displayName),
      subtitle: Text(user.email),
      trailing: OutlinedButton(
        onPressed: ref.read(authProvider.notifier).signOut,
        child: const Text('Sign out'),
      ),
    );
  }
}
