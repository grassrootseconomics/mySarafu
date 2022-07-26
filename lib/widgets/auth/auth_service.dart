// ignore_for_file: public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysarafu/utils/logger.dart';

/// Provide authentication services with [FirebaseAuth].
class AuthService {
  final _auth = FirebaseAuth.instance;

  // Future<void> emailAuth(
  //   AuthMode mode, {
  //   required String email,
  //   required String password,
  // }) {
  //   assert(
  //     mode != AuthMode.phone,
  //     'AuthMode can not be phone when emailAuth is called.',
  //   );

  //   try {
  //     if (mode == AuthMode.login) {
  //       return _auth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //     } else {
  //       return _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> anonymousAuth() {
    try {
      return _auth.signInAnonymously();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> phoneAuth({
    required String phoneNumber,
    required Future<String?> Function() smsCode,
  }) async {
    if (_auth.currentUser != null) {
      log.d('User is already signed in.');
      return;
    }
    try {
      final verifier = RecaptchaVerifier();

      final confirmationResult =
          await _auth.signInWithPhoneNumber(phoneNumber, verifier);

      final _smsCode = await smsCode.call();

      if (_smsCode != null) {
        await confirmationResult.confirm(_smsCode);
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) {
    try {
      return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign the Firebase user out.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
