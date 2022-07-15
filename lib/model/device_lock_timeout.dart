import 'package:flutter/material.dart';
import 'package:mysarafu/l10n/l10n.dart';
import 'package:mysarafu/model/setting_item.dart';

enum LockTimeoutOption { zero, one, five, fifteen, thirty, sixty }

/// Represent auto-lock delay when requiring auth to open
class LockTimeoutSetting extends SettingSelectionItem {
  LockTimeoutSetting(this.setting);
  LockTimeoutOption setting;

  @override
  String getDisplayName(BuildContext context) {
    final l10n = context.l10n;
    switch (setting) {
      case LockTimeoutOption.zero:
        return l10n.instantly;
      case LockTimeoutOption.one:
        return l10n.xMinute.replaceAll('%1', '1');
      case LockTimeoutOption.five:
        return l10n.xMinutes.replaceAll('%1', '5');
      case LockTimeoutOption.fifteen:
        return l10n.xMinutes.replaceAll('%1', '15');
      case LockTimeoutOption.thirty:
        return l10n.xMinutes.replaceAll('%1', '30');
      case LockTimeoutOption.sixty:
        return l10n.xMinutes.replaceAll('%1', '60');
    }
  }

  Duration getDuration() {
    switch (setting) {
      case LockTimeoutOption.zero:
        return const Duration(seconds: 3);
      case LockTimeoutOption.one:
        return const Duration(minutes: 1);
      case LockTimeoutOption.five:
        return const Duration(minutes: 5);
      case LockTimeoutOption.fifteen:
        return const Duration(minutes: 15);
      case LockTimeoutOption.thirty:
        return const Duration(minutes: 30);
      case LockTimeoutOption.sixty:
        return const Duration(minutes: 1);
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
