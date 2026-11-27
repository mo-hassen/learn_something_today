// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in reader, or null for a guest. Signing in is optional: a
/// guest can read, save and use every feature except cross-device sync.
///
/// The methods rethrow the repository's `ValidationException` so the form
/// can show the message next to the field.

@ProviderFor(Auth)
final authProvider = AuthProvider._();

/// The signed-in reader, or null for a guest. Signing in is optional: a
/// guest can read, save and use every feature except cross-device sync.
///
/// The methods rethrow the repository's `ValidationException` so the form
/// can show the message next to the field.
final class AuthProvider extends $NotifierProvider<Auth, AppUser?> {
  /// The signed-in reader, or null for a guest. Signing in is optional: a
  /// guest can read, save and use every feature except cross-device sync.
  ///
  /// The methods rethrow the repository's `ValidationException` so the form
  /// can show the message next to the field.
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser?>(value),
    );
  }
}

String _$authHash() => r'37800633648ef4e049da4046847eba3a002cc3b8';

/// The signed-in reader, or null for a guest. Signing in is optional: a
/// guest can read, save and use every feature except cross-device sync.
///
/// The methods rethrow the repository's `ValidationException` so the form
/// can show the message next to the field.

abstract class _$Auth extends $Notifier<AppUser?> {
  AppUser? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppUser?, AppUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppUser?, AppUser?>,
              AppUser?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
