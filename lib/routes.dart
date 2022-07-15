import 'package:flutter/material.dart';
import 'package:mysarafu/cubits/account/views/create_account_view.dart';
import 'package:mysarafu/screens/home_screen.dart';
import 'package:mysarafu/screens/landing_screen.dart';
import 'package:mysarafu/screens/lock_screen.dart';
import 'package:mysarafu/screens/settings_screen.dart';
import 'package:mysarafu/screens/vouchers_screen.dart';

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
    case '/landing':
      return MaterialPageRoute<Widget>(
        builder: (context) => const LandingView(),
      );
    default:
      return MaterialPageRoute<Widget>(
        builder: (context) => const AppLockScreen(),
      );
  }
}
