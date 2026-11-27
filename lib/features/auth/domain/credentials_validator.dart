/// Rules for the sign-in form. Pure functions: the form and the
/// repository both use them, and they are tested without any widget.
abstract final class CredentialsValidator {
  static const minPasswordLength = 6;

  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Returns a message when [value] is not a usable e-mail, otherwise null.
  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Enter your e-mail address.';
    if (!_email.hasMatch(text)) return 'Enter a valid e-mail address.';
    return null;
  }

  /// Returns a message when [value] is too short, otherwise null.
  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return 'Enter a password.';
    if (text.length < minPasswordLength) {
      return 'Use at least $minPasswordLength characters.';
    }
    return null;
  }
}
