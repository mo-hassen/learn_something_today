import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/features/auth/domain/credentials_validator.dart';

void main() {
  group('email', () {
    test('accepts a normal address', () {
      expect(CredentialsValidator.email('reader@example.com'), isNull);
      expect(CredentialsValidator.email('  reader@example.com  '), isNull);
    });

    test('rejects an empty or missing value', () {
      expect(CredentialsValidator.email(''), 'Enter your e-mail address.');
      expect(CredentialsValidator.email('   '), 'Enter your e-mail address.');
      expect(CredentialsValidator.email(null), 'Enter your e-mail address.');
    });

    test('rejects text that is not an address', () {
      for (final bad in [
        'reader',
        'reader@',
        '@example.com',
        'a@b',
        'a b@c.d',
      ]) {
        expect(
          CredentialsValidator.email(bad),
          'Enter a valid e-mail address.',
          reason: bad,
        );
      }
    });
  });

  group('password', () {
    test('accepts a password at the minimum length', () {
      expect(CredentialsValidator.password('123456'), isNull);
    });

    test('rejects one character fewer than the minimum', () {
      expect(
        CredentialsValidator.password('12345'),
        'Use at least 6 characters.',
      );
    });

    test('rejects an empty or missing value', () {
      expect(CredentialsValidator.password(''), 'Enter a password.');
      expect(CredentialsValidator.password(null), 'Enter a password.');
    });
  });
}
