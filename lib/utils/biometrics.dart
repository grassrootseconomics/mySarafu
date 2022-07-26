import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mysarafu/utils/logger.dart';

class BiometricUtil {
  ///
  /// hasBiometrics()
  ///
  /// @returns true if device has fingerprint/faceID available and registered, false otherwise
  Future<bool> hasBiometrics() async {
    if (Platform.isLinux) return false;
    final localAuth = LocalAuthentication();
    final canCheck = await localAuth.canCheckBiometrics;
    if (canCheck) {
      final availableBiometrics = await localAuth.getAvailableBiometrics();
      for (final type in availableBiometrics) {
        log.d(type.toString());
      }
      if (availableBiometrics.contains(BiometricType.face)) {
        return true;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return true;
      }
    }
    return false;
  }

  ///
  /// authenticateWithBiometrics()
  ///
  /// @param [message] Message shown to user in FaceID/TouchID popup
  /// @returns true if successfully authenticated, false otherwise
  Future<bool> authenticateWithBiometrics(
    BuildContext context,
    String message,
  ) async {
    final hasBiometricsEnrolled = await hasBiometrics();
    if (hasBiometricsEnrolled) {
      final localAuth = LocalAuthentication();
      return localAuth.authenticate(
        localizedReason: message,
        authMessages: [],
        options: const AuthenticationOptions(useErrorDialogs: false),
      );
    }
    return false;
  }
}
