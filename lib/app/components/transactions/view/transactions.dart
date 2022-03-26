import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/app/components/transactions/cubit/transactions_cubit.dart';
import 'package:my_sarafu/app/components/transactions/view/transaction.dart';
import 'package:my_sarafu/app/view/settings/cubit/account_cubit.dart';
import 'package:my_sarafu/app/view/settings/cubit/settings_cubit.dart';
import 'package:my_sarafu/app/view/tokens/cubit/tokens_cubit.dart';
import 'package:my_sarafu/data/tokens_repository.dart';
import 'package:my_sarafu/data/transactions_repository.dart';
import 'package:my_sarafu/wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final httpClient = Client();
    final ethClient = Web3Client(settings.rpcProvider, httpClient);
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = loadWallet(account.wallet, account.password);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionsCubit(
            TransactionsRepository(
              address: wallet.privateKey.address,
              cacheUrl: settings.cacheUrl,
            ),
          )..fetchAllTransactions(wallet.privateKey.address),
        ),
        BlocProvider(
          create: (context) => TokensCubit(
            TokenRepository(
              tokenRegisteryAddress: settings.tokenRegistryAddress,
              client: ethClient,
            ),
          ),
        ),
      ],
      child: const TransactionsWidget(),
    );
  }
}

/// Displays a list of SampleItems.
class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = loadWallet(account.wallet, account.password);
    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 3,
              child: RefreshIndicator(
                onRefresh: () => context
                    .read<TransactionsCubit>()
                    .fetchAllTransactions(wallet.privateKey.address),
                child: ListView.builder(
                  // Providing a restorationId allows the ListView to restore the
                  // scroll position when a user leaves and returns to the app after it
                  // has been killed while running in the background.
                  restorationId: 'sampleItemListView',
                  itemCount: state.transactions.data.length,

                  itemBuilder: (BuildContext context, int index) {
                    final transaction = state.transactions.data[index];

                    return TransactionWidget(transaction: transaction);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
