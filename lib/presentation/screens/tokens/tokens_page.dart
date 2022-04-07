import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/tokens/tokens_cubit.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/presentation/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:my_sarafu/presentation/widgets/token.dart';

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
  final account = context.read<AccountsCubit>().activeAccount;
  if (account == null) {
    return const Center(
      child: Text('No account selected'),
    );
  }
  return Center(
    child: TextButton(
      onPressed: () =>
          context.read<TokensCubit>().fetchAllTokens(account.address),
      child: const Text(
        'Fetch All Tokens',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget buildTokenList(BuildContext context, List<Token> tokens) {
  final tokenCubit = context.read<TokensCubit>();
  final account = context.read<AccountsCubit>().activeAccount;
  if (account == null) {
    return const Center(
      child: Text('No account selected'),
    );
  }

  return Expanded(
    child: Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => tokenCubit.fetchAllTokens(account.address),
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
