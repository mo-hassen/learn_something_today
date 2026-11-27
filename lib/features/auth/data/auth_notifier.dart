import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_user.dart';
import 'auth_repository.dart';

part 'auth_notifier.g.dart';

/// The signed-in reader, or null for a guest. Signing in is optional: a
/// guest can read, save and use every feature except cross-device sync.
///
/// The methods rethrow the repository's `ValidationException` so the form
/// can show the message next to the field.
@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AppUser? build() => ref.watch(authRepositoryProvider).currentUser;

  Future<void> signIn({required String email, required String password}) async {
    state = await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
  }

  Future<void> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = await ref
        .read(authRepositoryProvider)
        .register(email: email, password: password, displayName: displayName);
  }

  Future<void> signInWithGoogle() async {
    state = await ref.read(authRepositoryProvider).signInWithGoogle();
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = null;
  }
}
