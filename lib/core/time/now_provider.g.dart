// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The clock, as a provider, so the "article of the day" can be tested
/// with a fixed date.

@ProviderFor(now)
final nowProvider = NowProvider._();

/// The clock, as a provider, so the "article of the day" can be tested
/// with a fixed date.

final class NowProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// The clock, as a provider, so the "article of the day" can be tested
  /// with a fixed date.
  NowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return now(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$nowHash() => r'cd84bcb298b7b9e78457b899f2d2445afe8d297f';
