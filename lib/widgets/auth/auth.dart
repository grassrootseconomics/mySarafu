// ignore_for_file: use_build_context_synchronously, public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mysarafu/widgets/auth/animated_error.dart';
import 'package:mysarafu/widgets/auth/auth_service.dart';
import 'package:mysarafu/widgets/auth/sms_dialog.dart';

/// Helper class to show a snackbar using the passed context.
class ScaffoldSnackbar {
  ScaffoldSnackbar(this._context);

  /// The scaffold of current context.
  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  final BuildContext _context;

  /// Helper method to show a SnackBar.
  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          width: 400,
          content: SelectableText(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

// ignore: lines_longer_than_80_chars
/// The mode of the current auth session, either [AuthMode.login] or [AuthMode.register].
enum AuthMode { login, register, phone }

/// Supported Social OAuth providers.
enum SocialOAuthProvider { google, facebook, twitter, github, apple }

extension on AuthMode {
  String get label => this == AuthMode.login
      ? 'Sign in'
      : this == AuthMode.phone
          ? 'Sign in'
          : 'Register';
}

/// Entrypoint example for various sign-in flows with Firebase.
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error = '';

  AuthMode mode = AuthMode.login;

  bool isLoading = false;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void resetError() {
    if (error.isNotEmpty) {
      setState(() {
        error = '';
      });
    }
  }

  Future<void> _resetPassword() async {
    resetError();

    String? email;

    await showDialog<Widget>(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email'),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
              ),
            ],
          ),
        );
      },
    );

    if (email != null) {
      try {
        await authService.resetPassword(email!);
        ScaffoldSnackbar.of(context).show('Password reset email is sent');
      } catch (e) {
        ScaffoldSnackbar.of(context).show('Error resetting');
      }
    }
  }

  Future<void> _emailAuth() async {
    resetError();

    if (formKey.currentState?.validate() ?? false) {
      setIsLoading();

      try {
        // await authService.emailAuth(
        //   mode,
        //   email: emailController.text,
        //   password: passwordController.text,
        // );
      } on FirebaseAuthException catch (e) {
        setIsLoading();

        setState(() {
          error = '${e.message}';
        });
      } catch (e) {
        setIsLoading();
      }
    }
  }

  Future<void> _anonymousAuth() async {
    setIsLoading();

    try {
      await authService.anonymousAuth();
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = '${e.message}';
      });
    } catch (e) {
      setState(() {
        error = '$e';
      });
    } finally {
      setIsLoading();
    }
  }

  Future<void> _phoneAuth() async {
    resetError();

    try {
      setIsLoading();
      await authService.phoneAuth(
        phoneNumber: phoneController.text,
        smsCode: () {
          return SMSDialog.of(context).show('SMS Code:', 'Sign in');
        },
      );
    } catch (e) {
      setState(() {
        error = '$e';
      });
    } finally {
      setIsLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  width: 400,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedError(text: error, show: error.isNotEmpty),
                        const SizedBox(height: 20),
                        if (mode != AuthMode.phone)
                          Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration:
                                    const InputDecoration(hintText: 'Email'),
                                validator: (value) =>
                                    value != null && value.isNotEmpty
                                        ? null
                                        : 'Required',
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration:
                                    const InputDecoration(hintText: 'Password'),
                                validator: (value) =>
                                    value != null && value.isNotEmpty
                                        ? null
                                        : 'Required',
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (mode != AuthMode.phone)
                          TextButton(
                            onPressed: _resetPassword,
                            child: const Text('Forgot password?'),
                          ),
                        if (mode == AuthMode.phone)
                          TextFormField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              hintText: '+2540723522715',
                              labelText: 'Phone number',
                            ),
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : mode == AuthMode.phone
                                    ? _phoneAuth
                                    : _emailAuth,
                            child: Text(mode.label),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (mode != AuthMode.phone) {
                                      setState(() {
                                        mode = AuthMode.phone;
                                      });
                                    } else {
                                      setState(() {
                                        mode = AuthMode.login;
                                      });
                                    }
                                  },
                            child: Text(
                              mode != AuthMode.phone
                                  ? 'Sign in with Phone Number'
                                  : 'sign in with Email and Password',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (mode != AuthMode.phone)
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                                TextSpan(
                                  text: mode == AuthMode.login
                                      ? "Don't have an account? "
                                      : 'You have an account? ',
                                ),
                                TextSpan(
                                  text: mode == AuthMode.login
                                      ? 'Register now'
                                      : 'Click to login',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        mode = mode == AuthMode.login
                                            ? AuthMode.register
                                            : AuthMode.login;
                                      });
                                    },
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              const TextSpan(text: 'Or '),
                              TextSpan(
                                text: 'continue as guest',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _anonymousAuth,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading
                ? Container(
                    color: Colors.black.withOpacity(0.8),
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
