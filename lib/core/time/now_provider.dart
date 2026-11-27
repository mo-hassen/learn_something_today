import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now_provider.g.dart';

/// The clock, as a provider, so the "article of the day" can be tested
/// with a fixed date.
@riverpod
DateTime now(Ref ref) => DateTime.now();
