import 'package:flutter/material.dart';

/// Models that are used in settings dialogs/dropdowns
// ignore: one_member_abstracts
abstract class SettingSelectionItem {
  String getDisplayName(BuildContext context);
}
