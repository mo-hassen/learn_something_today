import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_aloud_notifier.g.dart';

/// Whether the open article is being read aloud.
///
/// In Milestone 1 this only holds the play/pause state that the reader
/// screen shows. Milestone 2 puts a text-to-speech service behind it.
/// The state is thrown away when the reader closes (auto-dispose), so
/// speech never carries over to another article.
@riverpod
class ReadingAloud extends _$ReadingAloud {
  @override
  bool build() => false;

  void toggle() => state = !state;
}
