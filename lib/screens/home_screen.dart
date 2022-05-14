import 'package:flutter/material.dart';
import 'package:my_sarafu/cubits/transactions/views/transactions.dart';
import 'package:my_sarafu/widgets/balance.dart';
import 'package:my_sarafu/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:my_sarafu/widgets/recent.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
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
      ),
    );
  }
}
