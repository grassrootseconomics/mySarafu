// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/app/components/bottom_nav/view/bottom_nav.dart';
import 'package:my_sarafu/app/components/token.dart';
import 'package:my_sarafu/app/view/settings/cubit/account_cubit.dart';
import 'package:my_sarafu/cubit/tokens/tokens_cubit.dart';
import 'package:my_sarafu/data/model/token.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:my_sarafu/wallet/wallet.dart';

class TokensView extends StatelessWidget {
  const TokensView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<TokensCubit, TokensState>(
              listener: (context, state) {
                log.d('TokensCubit changed: $state');
                if (state is TokensError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is TokensInitial) {
                  return buildInitialInput(context);
                } else if (state is TokensLoaded) {
                  return buildTokenList(context, state.tokens);
                } else {
                  // (state is WeatherError)
                  return buildInitialInput(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInitialInput(BuildContext context) {
  final account = context.select((AccountCubit cubit) => cubit.state);
  final wallet = unlockWallet(account.wallet, account.password);
  return Center(
    child: TextButton(
      onPressed: () =>
          context.read<TokensCubit>().fetchAllTokens(wallet.privateKey.address),
      child: const Text(
        'Fetch All Tokens',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget buildTokenList(BuildContext context, List<TokenItem> tokens) {
  final tokenCubit = context.read<TokensCubit>();
  final account = context.select((AccountCubit cubit) => cubit.state);
  final wallet = unlockWallet(account.wallet, account.password);

  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                tokenCubit.fetchAllTokens(wallet.privateKey.address),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.builder(
                // Providing a restorationId allows the ListView to restore the
                // scroll position when a user leaves and returns to the app after it
                // has been killed while running in the background.
                restorationId: 'tokensListView',
                itemCount: tokens.length,
                itemBuilder: (BuildContext context, int index) {
                  final token = tokens[index];
                  return TokenWidget(token: token);
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
