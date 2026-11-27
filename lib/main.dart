import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  // One ProviderScope stores the state of every provider. Riverpod 3 retries
  // a failed provider on its own; there is no network yet, so a failure
  // should show its error at once. Milestone 2 turns retries on for
  // network errors only.
  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      child: const LearnSomethingTodayApp(),
    ),
  );
}
