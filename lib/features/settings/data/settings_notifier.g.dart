// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reader's preferences and the operations that change them.
///
/// Every method assigns a new [AppSettings] to `state`, then hands it to
/// the repository to keep.

@ProviderFor(Settings)
final settingsProvider = SettingsProvider._();

/// The reader's preferences and the operations that change them.
///
/// Every method assigns a new [AppSettings] to `state`, then hands it to
/// the repository to keep.
final class SettingsProvider extends $NotifierProvider<Settings, AppSettings> {
  /// The reader's preferences and the operations that change them.
  ///
  /// Every method assigns a new [AppSettings] to `state`, then hands it to
  /// the repository to keep.
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettings>(value),
    );
  }
}

String _$settingsHash() => r'369098ba2ed2ac38718deef309c5c263ae94cd8b';

/// The reader's preferences and the operations that change them.
///
/// Every method assigns a new [AppSettings] to `state`, then hands it to
/// the repository to keep.

abstract class _$Settings extends $Notifier<AppSettings> {
  AppSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppSettings, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppSettings, AppSettings>,
              AppSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
