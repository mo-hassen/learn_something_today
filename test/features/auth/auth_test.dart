import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_something_today/core/network/app_exception.dart';
import 'package:learn_something_today/features/auth/data/auth_notifier.dart';
import 'package:learn_something_today/features/auth/data/auth_repository.dart';

void main() {
  group('InMemoryAuthRepository', () {
    late InMemoryAuthRepository repository;

    setUp(() {
      repository = InMemoryAuthRepository(delay: Duration.zero);
    });

    test('nobody is signed in at the start', () {
      expect(repository.currentUser, isNull);
    });

    test('register signs the new reader in', () async {
      final user = await repository.register(
        email: 'Reader@Example.com',
        password: 'secret1',
        displayName: 'Tigist',
      );
      expect(user.email, 'reader@example.com');
      expect(user.displayName, 'Tigist');
      expect(repository.currentUser, user);
    });

    test('the display name defaults to the start of the e-mail', () async {
      final user = await repository.register(
        email: 'reader@example.com',
        password: 'secret1',
      );
      expect(user.displayName, 'reader');
    });

    test('register refuses an e-mail that is already used', () async {
      await repository.register(email: 'a@example.com', password: 'secret1');
      expect(
        repository.register(email: 'A@example.com', password: 'secret2'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('signIn accepts the right password', () async {
      await repository.register(email: 'a@example.com', password: 'secret1');
      await repository.signOut();
      final user = await repository.signIn(
        email: 'a@example.com',
        password: 'secret1',
      );
      expect(repository.currentUser, user);
    });

    test('signIn rejects a wrong password with a clear message', () async {
      await repository.register(email: 'a@example.com', password: 'secret1');
      await expectLater(
        repository.signIn(email: 'a@example.com', password: 'wrong-one'),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.message,
            'message',
            'The password is not correct.',
          ),
        ),
      );
    });

    test('signIn rejects an e-mail that has no account', () {
      expect(
        repository.signIn(email: 'nobody@example.com', password: 'secret1'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('invalid input is rejected before anything is stored', () async {
      await expectLater(
        repository.register(email: 'not-an-email', password: 'secret1'),
        throwsA(isA<ValidationException>()),
      );
      await expectLater(
        repository.register(email: 'a@example.com', password: '123'),
        throwsA(isA<ValidationException>()),
      );
      expect(repository.currentUser, isNull);
    });

    test('signOut clears the current user', () async {
      await repository.register(email: 'a@example.com', password: 'secret1');
      await repository.signOut();
      expect(repository.currentUser, isNull);
    });

    test('the Google demo signs in without a password', () async {
      final user = await repository.signInWithGoogle();
      expect(user.displayName, 'Demo reader');
      expect(repository.currentUser, user);
    });
  });

  group('Auth notifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer.test(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            InMemoryAuthRepository(delay: Duration.zero),
          ),
        ],
      );
    });

    test('the state is null for a guest', () {
      expect(container.read(authProvider), isNull);
    });

    test('signing in and out changes the state', () async {
      final auth = container.read(authProvider.notifier);
      await auth.register(email: 'a@example.com', password: 'secret1');
      expect(container.read(authProvider)?.email, 'a@example.com');
      await auth.signOut();
      expect(container.read(authProvider), isNull);
    });

    test(
      'a rejected sign-in leaves the state unchanged and rethrows',
      () async {
        final auth = container.read(authProvider.notifier);
        await expectLater(
          auth.signIn(email: 'a@example.com', password: 'secret1'),
          throwsA(isA<ValidationException>()),
        );
        expect(container.read(authProvider), isNull);
      },
    );
  });
}
