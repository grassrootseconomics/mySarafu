import 'package:flutter/material.dart';
import 'package:my_sarafu/app/view/home/home.dart';

import 'package:my_sarafu/l10n/l10n.dart';

void changeRoute(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/');
      break;
    case 1:
      Navigator.pushNamed(context, '/tokens');
      break;
    case 2:
      Navigator.pushNamed(context, '/settings');
      break;
    default:
      Navigator.pushNamed(context, '/');
      break;
  }
}
/// Displays a list of SampleItems.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    this.src = 'assets/images/sarafu_logo.png',
  }) : super(key: key);

  final String src;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BottomNavigationBar(
        onTap: (index) => changeRoute(context, index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.homePageTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.token_rounded),
            label: l10n.tokensPageTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.settingsPageTitle,
          ),
        ]);
  }
}
