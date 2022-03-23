import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/app/components/loading.dart';
import 'package:my_sarafu/app/components/token.dart';
import 'package:my_sarafu/app/components/tokens/cubit/tokens_cubit.dart';
import 'package:my_sarafu/app/view/settings/cubit/account_cubit.dart';
import 'package:my_sarafu/app/view/settings/cubit/settings_cubit.dart';
import 'package:my_sarafu/data/model/token.dart';
import 'package:my_sarafu/data/tokens_repository.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:my_sarafu/wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

/// Displays a list of SampleItems.
class TokensWidget extends StatelessWidget {
  const TokensWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = loadWallet(account.wallet, account.password);
    final httpClient = Client();
    final ethClient = Web3Client(settings.rpcProvider, httpClient);
    return BlocProvider(
      create: (context) => TokensCubit(TokenRepository(
          tokenRegisteryAddress: settings.tokenRegistryAddress,
          client: ethClient)
        ..getTokens(wallet.privateKey.address)),
      child: BlocConsumer<TokensCubit, TokensState>(
        listener: (context, state) {
          if (state is TokensError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          if (state is TokensInitial) {
            final tokensCubit = context.read<TokensCubit>();
            tokensCubit.getTokens(wallet.privateKey.address);
            return buildInitialInput();
          } else if (state is TokensLoading) {
            return buildLoading();
          } else if (state is TokensLoaded) {
            return buildTokenList(state.tokens);
          } else {
            // (state is WeatherError)
            return buildInitialInput();
          }
        },
      ),
    );
  }
}

Widget buildInitialInput() {
  return const Center(
    child: Text('Hmm'),
  );
}

Widget buildLoading() {
  return const Center(
    child: Loading(),
  );
}

Expanded buildTokenList(List<TokenItem> tokens) {
  return Expanded(
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
  );
}
