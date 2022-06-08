import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/cubits/accounts/accounts_cubit.dart';
import 'package:my_sarafu/cubits/settings/settings_cubit.dart';
import 'package:my_sarafu/cubits/vouchers/vouchers_cubit.dart';
import 'package:my_sarafu/data/registry_repository.dart';
import 'package:my_sarafu/data/vouchers_repository.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/routes.dart';
import 'package:my_sarafu/widgets/bottom_nav/cubit/nav_cubit.dart';
import 'package:web3dart/web3dart.dart';

final httpClient = Client();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navCubit = NavCubit();
    final settingsCubit = SettingsCubit();
    final accountsCubit = AccountsCubit();
    final voucherCubit = VouchersCubit(
      VoucherRepository(
        settings: settingsCubit.state,
        registryRepo: RegistryRepository(
          contractRegistry: settingsCubit.state.contractRegistryAddress,
          client: Web3Client(
            settingsCubit.state.rpcProvider,
            httpClient,
          ),
        ),
        client: Web3Client(
          settingsCubit.state.rpcProvider,
          httpClient,
        ),
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => navCubit),
        BlocProvider(create: (_) => settingsCubit),
        BlocProvider(create: (_) => accountsCubit),
        BlocProvider(create: (_) => voucherCubit),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context
          .select<SettingsCubit, ThemeMode>((cubit) => cubit.state.themeMode),
      onGenerateRoute: (routeSettings) =>
          onGenerateRoute(context, routeSettings),
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
      initialRoute: '/home',
    );
  }
}
