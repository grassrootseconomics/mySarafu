import 'package:flutter/material.dart';
import 'package:my_sarafu/cubits/account/views/create_account_view.dart';
import 'package:my_sarafu/screens/home_screen.dart';
import 'package:my_sarafu/screens/lock_screen.dart';
import 'package:my_sarafu/screens/settings_screen.dart';
import 'package:my_sarafu/screens/vouchers_screen.dart';

MaterialPageRoute onGenerateRoute(BuildContext context, RouteSettings route) {
  switch (route.name) {
    case '/create_account':
      return MaterialPageRoute<Widget>(
        builder: (_) => const CreateAccountScreen(),
      );
    case '/home':
      return MaterialPageRoute<Widget>(
        builder: (context) => const HomeView(),
      );
    case '/vouchers':
      return MaterialPageRoute<Widget>(
        builder: (context) => const VouchersView(),
      );
    case '/settings':
      return MaterialPageRoute<Widget>(
        builder: (context) => const SettingsView(),
      );
    case '/locked':
      return MaterialPageRoute<Widget>(
        builder: (context) => const AppLockScreen(),
      );
    default:
      return MaterialPageRoute<Widget>(
        builder: (context) => const AppLockScreen(),
      );
  }
}
