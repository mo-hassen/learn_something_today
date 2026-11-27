// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the reader agreed to the AI notice. The AI buttons stay hidden
/// until this is true. Kept for the session; Milestone 2 stores it.

@ProviderFor(AiConsent)
final aiConsentProvider = AiConsentProvider._();

/// Whether the reader agreed to the AI notice. The AI buttons stay hidden
/// until this is true. Kept for the session; Milestone 2 stores it.
final class AiConsentProvider extends $NotifierProvider<AiConsent, bool> {
  /// Whether the reader agreed to the AI notice. The AI buttons stay hidden
  /// until this is true. Kept for the session; Milestone 2 stores it.
  AiConsentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiConsentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiConsentHash();

  @$internal
  @override
  AiConsent create() => AiConsent();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$aiConsentHash() => r'5396b77509d6be4fad4fec2560eba6207e8cd27f';

/// Whether the reader agreed to the AI notice. The AI buttons stay hidden
/// until this is true. Kept for the session; Milestone 2 stores it.

abstract class _$AiConsent extends $Notifier<bool> {
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

/// The simplified text of an article. `AsyncData(null)` means nothing was
/// asked for yet; a click on the button calls [simplify].

@ProviderFor(Simplify)
final simplifyProvider = SimplifyProvider._();

/// The simplified text of an article. `AsyncData(null)` means nothing was
/// asked for yet; a click on the button calls [simplify].
final class SimplifyProvider extends $AsyncNotifierProvider<Simplify, String?> {
  /// The simplified text of an article. `AsyncData(null)` means nothing was
  /// asked for yet; a click on the button calls [simplify].
  SimplifyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simplifyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simplifyHash();

  @$internal
  @override
  Simplify create() => Simplify();
}

String _$simplifyHash() => r'2722118db67247c3bd1ad4db775887343683b913';

/// The simplified text of an article. `AsyncData(null)` means nothing was
/// asked for yet; a click on the button calls [simplify].

abstract class _$Simplify extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The quiz for an article, built on request in the same way.

@ProviderFor(QuizMaker)
final quizMakerProvider = QuizMakerProvider._();

/// The quiz for an article, built on request in the same way.
final class QuizMakerProvider extends $AsyncNotifierProvider<QuizMaker, Quiz?> {
  /// The quiz for an article, built on request in the same way.
  QuizMakerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizMakerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizMakerHash();

  @$internal
  @override
  QuizMaker create() => QuizMaker();
}

String _$quizMakerHash() => r'edd5293c1254d5ce671cff35783884a80be91dbd';

/// The quiz for an article, built on request in the same way.

abstract class _$QuizMaker extends $AsyncNotifier<Quiz?> {
  FutureOr<Quiz?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Quiz?>, Quiz?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Quiz?>, Quiz?>,
              AsyncValue<Quiz?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Finished quizzes, kept on the device.

@ProviderFor(QuizResults)
final quizResultsProvider = QuizResultsProvider._();

/// Finished quizzes, kept on the device.
final class QuizResultsProvider
    extends $NotifierProvider<QuizResults, List<QuizResult>> {
  /// Finished quizzes, kept on the device.
  QuizResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizResultsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizResultsHash();

  @$internal
  @override
  QuizResults create() => QuizResults();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<QuizResult> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<QuizResult>>(value),
    );
  }
}

String _$quizResultsHash() => r'a10846fe295d69e4c74c0d1722d2a39dc49ae50f';

/// Finished quizzes, kept on the device.

abstract class _$QuizResults extends $Notifier<List<QuizResult>> {
  List<QuizResult> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<QuizResult>, List<QuizResult>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<QuizResult>, List<QuizResult>>,
              List<QuizResult>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The earlier results for one article, oldest first.

@ProviderFor(quizResultsFor)
final quizResultsForProvider = QuizResultsForFamily._();

/// The earlier results for one article, oldest first.

final class QuizResultsForProvider
    extends
        $FunctionalProvider<
          List<QuizResult>,
          List<QuizResult>,
          List<QuizResult>
        >
    with $Provider<List<QuizResult>> {
  /// The earlier results for one article, oldest first.
  QuizResultsForProvider._({
    required QuizResultsForFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'quizResultsForProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizResultsForHash();

  @override
  String toString() {
    return r'quizResultsForProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<QuizResult>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<QuizResult> create(Ref ref) {
    final argument = this.argument as String;
    return quizResultsFor(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<QuizResult> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<QuizResult>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QuizResultsForProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizResultsForHash() => r'9bfc579d291d4487e7f89cfbbdb9bd5872a606bb';

/// The earlier results for one article, oldest first.

final class QuizResultsForFamily extends $Family
    with $FunctionalFamilyOverride<List<QuizResult>, String> {
  QuizResultsForFamily._()
    : super(
        retry: null,
        name: r'quizResultsForProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The earlier results for one article, oldest first.

  QuizResultsForProvider call(String articleId) =>
      QuizResultsForProvider._(argument: articleId, from: this);

  @override
  String toString() => r'quizResultsForProvider';
}
