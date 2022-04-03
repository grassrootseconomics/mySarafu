import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:my_sarafu/presentation/components/bottom_nav/cubit/nav_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    this.src = 'assets/images/sarafu_logo.png',
  }) : super(key: key);

  final String src;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<NavCubit, NavState>(
      listener: (context, state) {
        Navigator.pushReplacementNamed(context, state.route);
      },
      builder: (context, state) {
        final nav = context.read<NavCubit>();
        log.d('${nav.state.bottomNavIndex} - ${nav.state.route}');
        return BottomNavigationBar(
          onTap: nav.changeRoute,
          currentIndex: nav.state.bottomNavIndex,
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
          ],
        );
      },
    );
  }
}
