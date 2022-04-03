// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/presentation/widgets/balance.dart';
import 'package:my_sarafu/presentation/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:my_sarafu/presentation/widgets/recent.dart';
import 'package:my_sarafu/presentation/widgets/transactions/transactions.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        body: SafeArea(
          child: Column(
            children: const <Widget>[
              BalanceView(),
              RecentWidget(),
              TransactionsView(),
            ],
          ),
        ));
  }
}
