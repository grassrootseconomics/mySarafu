import 'package:flutter/material.dart';
import 'package:mysarafu/l10n/l10n.dart';
import 'package:mysarafu/model/setting_item.dart';

enum UnlockOption { yes, no }

/// Represent authenticate to open setting
class UnlockSetting extends SettingSelectionItem {
  UnlockSetting(this.setting);
  UnlockOption setting;

  @override
  String getDisplayName(BuildContext context) {
    final l10n = context.l10n;

    switch (setting) {
      case UnlockOption.yes:
        return l10n.yes;
      case UnlockOption.no:
        return l10n.no;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
