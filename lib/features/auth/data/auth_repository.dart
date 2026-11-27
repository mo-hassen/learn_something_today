import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../domain/app_user.dart';
import '../domain/credentials_validator.dart';

part 'auth_repository.g.dart';

/// Where accounts live. Milestone 2 adds a Firebase Auth implementation;
/// the sign-in screen and the notifier above it do not change.
///
/// Methods throw a [ValidationException] when the input is rejected.
abstract interface class AuthRepository {
  AppUser? get currentUser;

  Future<AppUser> signIn({required String email, required String password});

  Future<AppUser> register({
    required String email,
    required String password,
    String? displayName,
  });

  Future<AppUser> signInWithGoogle();

  Future<void> signOut();
}

/// Keeps accounts in memory: they are lost when the app closes.
class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;
  final _passwords = <String, String>{};
  final _users = <String, AppUser>{};
  AppUser? _current;
  int _nextId = 1;

  @override
  AppUser? get currentUser => _current;

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);
    final key = _validated(email, password);
    final user = _users[key];
    if (user == null) {
      throw const ValidationException('No account uses this e-mail address.');
    }
    if (_passwords[key] != password) {
      throw const ValidationException('The password is not correct.');
    }
    return _current = user;
  }

  @override
  Future<AppUser> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await Future<void>.delayed(delay);
    final key = _validated(email, password);
    if (_users.containsKey(key)) {
      throw const ValidationException('An account already uses this e-mail.');
    }
    final name = displayName?.trim() ?? '';
    final user = AppUser(
      id: 'u${_nextId++}',
      email: key,
      displayName: name.isEmpty ? key.split('@').first : name,
      createdAt: DateTime.now(),
    );
    _users[key] = user;
    _passwords[key] = password;
    return _current = user;
  }

  /// Stands in for Google sign-in until Firebase arrives in Milestone 2.
  @override
  Future<AppUser> signInWithGoogle() async {
    await Future<void>.delayed(delay);
    return _current = AppUser(
      id: 'google-demo',
      email: 'reader@example.com',
      displayName: 'Demo reader',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> signOut() async {
    _current = null;
  }

  /// Returns the normalised e-mail, or throws the first problem found.
  String _validated(String email, String password) {
    final problem =
        CredentialsValidator.email(email) ??
        CredentialsValidator.password(password);
    if (problem != null) throw ValidationException(problem);
    return email.trim().toLowerCase();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => InMemoryAuthRepository();
