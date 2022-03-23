// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_sarafu/app/view/home/home.dart';
import 'package:my_sarafu/app/view/settings/settings.dart';
import 'package:my_sarafu/app/view/tokens/view/tokens_page.dart';
import 'package:my_sarafu/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          brightness: Brightness.dark,
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
          brightness: Brightness.light,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => HomePage(),
        '/tokens': (context) => TokensPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
