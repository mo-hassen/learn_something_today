import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/router/navigation.dart';
import '../data/auth_notifier.dart';
import '../domain/credentials_validator.dart';

/// Sign in or create an account. Signing in is optional, so the screen
/// always offers a way to carry on as a guest.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  // Text controllers, the form key and the two flags below are ephemeral
  // UI state. The signed-in user is app state and lives in authProvider.
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  bool _registering = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  void _leave() => context.popOrGoHome();

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      if (mounted) _leave();
    } on AppException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = ref.read(authProvider.notifier);
    await _run(
      () => _registering
          ? auth.register(
              email: _email.text,
              password: _password.text,
              displayName: _name.text,
            )
          : auth.signIn(email: _email.text, password: _password.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_registering ? 'Create account' : 'Sign in')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_registering) ...[
                    TextFormField(
                      controller: _name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Name (optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    validator: CredentialsValidator.email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: CredentialsValidator.password,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _error!,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _busy ? null : _submit,
                    child: _busy
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_registering ? 'Create account' : 'Sign in'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _busy
                        ? null
                        : () => _run(
                            ref.read(authProvider.notifier).signInWithGoogle,
                          ),
                    icon: const Icon(Icons.login),
                    label: const Text('Continue with Google (demo)'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _busy
                        ? null
                        : () => setState(() {
                            _registering = !_registering;
                            _error = null;
                          }),
                    child: Text(
                      _registering
                          ? 'I already have an account'
                          : 'Create a new account',
                    ),
                  ),
                  TextButton(
                    onPressed: _busy ? null : _leave,
                    child: const Text('Continue without an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
