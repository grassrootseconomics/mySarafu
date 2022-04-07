import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/presentation/routes.dart';
import 'package:my_sarafu/presentation/widgets/bottom_nav/cubit/nav_cubit.dart';

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
          create: (_) => AccountsCubit(),
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
