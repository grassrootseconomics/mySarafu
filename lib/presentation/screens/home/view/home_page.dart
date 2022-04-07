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
        bottomNavigationBar: const BottomNavBar(key: Key('bottomNavBar')),
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
