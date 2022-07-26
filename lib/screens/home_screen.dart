import 'package:flutter/material.dart';
import 'package:mysarafu/cubits/transactions/views/transactions.dart';
import 'package:mysarafu/widgets/balance.dart';
import 'package:mysarafu/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:mysarafu/widgets/recent.dart';

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
