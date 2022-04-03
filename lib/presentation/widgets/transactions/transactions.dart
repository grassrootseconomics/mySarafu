import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/accounts/account_cubit.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/cubit/transactions/transactions_cubit.dart';
import 'package:my_sarafu/logic/data/transactions_repository.dart';
import 'package:my_sarafu/logic/wallet/wallet.dart';
import 'package:my_sarafu/presentation/widgets/transactions/transaction.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = unlockWallet(account.wallet, account.password);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionsCubit(
            TransactionsRepository(
              address: wallet.privateKey.address,
              cacheUrl: settings.cacheUrl,
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
    final wallet = unlockWallet(account.wallet, account.password);
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
