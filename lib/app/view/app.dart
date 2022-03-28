// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/app/components/bottom_nav/cubit/nav_cubit.dart';
import 'package:my_sarafu/app/view/home/home.dart';
import 'package:my_sarafu/app/view/landing/landing.dart';
import 'package:my_sarafu/app/view/settings/settings_page.dart';
import 'package:my_sarafu/app/view/tokens/tokens_page.dart';
import 'package:my_sarafu/cubit/accounts/account_cubit.dart';
import 'package:my_sarafu/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/cubit/tokens/tokens_cubit.dart';
import 'package:my_sarafu/data/tokens_repository.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavCubit(),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(),
        ),
        BlocProvider(
          create: (_) => AccountCubit(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode =
        context.select((SettingsCubit cubit) => cubit.state.darkMode);
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final httpClient = Client();
    final ethClient = Web3Client(settings.rpcProvider, httpClient);
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = unlockWallet(account.wallet, account.password);
    return BlocProvider(
      create: (context) => TokensCubit(
        TokenRepository(
          tokenRegisteryAddress: settings.tokenRegistryAddress,
          client: ethClient,
        ),
      )..updateBalances(wallet.privateKey.address),
      child: MaterialApp(
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          colorScheme: const ColorScheme(
            primary: Colors.green,
            secondary: Colors.green,
            background: Colors.green,
            surface: Colors.green,
            onBackground: Colors.white,
            error: Colors.redAccent,
            onError: Color.fromARGB(255, 70, 70, 70),
            onPrimary: Color.fromARGB(255, 0, 0, 0),
            onSecondary: Color.fromARGB(255, 0, 0, 0),
            onSurface: Color.fromARGB(255, 0, 0, 0),
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme(
            primary: Colors.green,
            secondary: Colors.green,
            background: Colors.green,
            surface: Colors.green,
            onBackground: Colors.white,
            error: Colors.redAccent,
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            brightness: Brightness.dark,
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeView(),
          '/tokens': (context) => const TokensView(),
          '/settings': (context) => const SettingsView(),
          '/landing': (context) => const LandingPage(),
        },
      ),
    );
  }
}
