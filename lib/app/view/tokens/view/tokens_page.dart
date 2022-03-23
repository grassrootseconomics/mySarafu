// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/app/components/bottom_nav.dart';
import 'package:my_sarafu/app/components/tokens/view/tokens_widget.dart';
import 'package:my_sarafu/app/view/settings/cubit/account_cubit.dart';
import 'package:my_sarafu/app/view/settings/settings.dart';
import 'package:my_sarafu/l10n/l10n.dart';

class TokensPage extends StatelessWidget {
  const TokensPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocProvider(
        create: (_) => AccountCubit(),
        child: TokensView(),
      ),
    );
  }
}

class TokensView extends StatelessWidget {
  const TokensView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        bottomNavigationBar: const BottomNavBar(),
        body: Column(
          children: const <Widget>[
            TokensWidget(),
          ],
        ));
  }
}
