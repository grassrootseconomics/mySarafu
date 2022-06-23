import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/cubits/accounts/accounts_cubit.dart';
import 'package:my_sarafu/screens/home_screen.dart';
import 'package:my_sarafu/screens/landing_screen.dart';
import 'package:my_sarafu/screens/lock_screen.dart';
import 'package:my_sarafu/screens/settings_screen.dart';
import 'package:my_sarafu/screens/vouchers_screen.dart';

MaterialPageRoute onGenerateRoute(BuildContext context, RouteSettings route) {
  if (context.read<AccountsCubit>().activeAccount == null) {
    return MaterialPageRoute<Widget>(
      builder: (_) => const LandingView(),
    );
  }
  switch (route.name) {
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
        builder: (context) => const LandingView(),
      );
  }
}
