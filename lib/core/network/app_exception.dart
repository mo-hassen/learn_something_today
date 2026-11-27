/// The one family of errors the UI knows about.
///
/// Data sources translate whatever they throw into one of these, so a
/// screen can `switch` over the cases and never needs to import a plugin.
/// Because the class is `sealed`, adding a case makes every incomplete
/// `switch` fail to compile.
sealed class AppException implements Exception {
  const AppException(this.message);

  /// A short sentence that is safe to show to the user.
  final String message;

  @override
  String toString() => message;
}

/// The thing that was asked for does not exist.
final class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

/// The input was rejected (bad e-mail, wrong password, ...).
final class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// The source could not be reached. Used by the REST implementation in
/// Milestone 2; tests use it today to simulate a failing source.
final class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// A user-facing sentence for any error that reaches the UI.
String describeError(Object error) {
  return switch (error) {
    final AppException e => e.message,
    _ => 'Something went wrong. Please try again.',
  };
}
