// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_aloud_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the open article is being read aloud.
///
/// In Milestone 1 this only holds the play/pause state that the reader
/// screen shows. Milestone 2 puts a text-to-speech service behind it.
/// The state is thrown away when the reader closes (auto-dispose), so
/// speech never carries over to another article.

@ProviderFor(ReadingAloud)
final readingAloudProvider = ReadingAloudProvider._();

/// Whether the open article is being read aloud.
///
/// In Milestone 1 this only holds the play/pause state that the reader
/// screen shows. Milestone 2 puts a text-to-speech service behind it.
/// The state is thrown away when the reader closes (auto-dispose), so
/// speech never carries over to another article.
final class ReadingAloudProvider extends $NotifierProvider<ReadingAloud, bool> {
  /// Whether the open article is being read aloud.
  ///
  /// In Milestone 1 this only holds the play/pause state that the reader
  /// screen shows. Milestone 2 puts a text-to-speech service behind it.
  /// The state is thrown away when the reader closes (auto-dispose), so
  /// speech never carries over to another article.
  ReadingAloudProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingAloudProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingAloudHash();

  @$internal
  @override
  ReadingAloud create() => ReadingAloud();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$readingAloudHash() => r'204b2910fd69ae5a41f139581a86f5b460dd0593';

/// Whether the open article is being read aloud.
///
/// In Milestone 1 this only holds the play/pause state that the reader
/// screen shows. Milestone 2 puts a text-to-speech service behind it.
/// The state is thrown away when the reader closes (auto-dispose), so
/// speech never carries over to another article.

abstract class _$ReadingAloud extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
