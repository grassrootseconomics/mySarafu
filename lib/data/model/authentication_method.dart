import 'package:flutter/material.dart';
import 'package:my_sarafu/data/model/setting_item.dart';
import 'package:my_sarafu/l10n/l10n.dart';

enum AuthMethod { pin, biometrics }

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthenticationMethod(this.method);
  AuthMethod method;

  @override
  String getDisplayName(BuildContext context) {
    final l10n = context.l10n;

    switch (method) {
      case AuthMethod.biometrics:
        return l10n.biometricsMethod;
      case AuthMethod.pin:
        return l10n.pinMethod;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
