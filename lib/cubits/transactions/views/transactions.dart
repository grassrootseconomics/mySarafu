import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mysarafu/cubits/account/cubit.dart';
import 'package:mysarafu/cubits/settings/settings_cubit.dart';
import 'package:mysarafu/cubits/transactions/transactions_cubit.dart';
import 'package:mysarafu/cubits/transactions/views/transaction.dart';
import 'package:mysarafu/model/transaction.dart';
import 'package:mysarafu/repository/cache_repository.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final account = context.read<AccountCubit>().state.account;
    if (account == null) {
      return const Center(
        child: Text('No account selected'),
      );
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionsCubit(
            CacheRepository(
              address: account.activeWalletAddress,
              cacheUrl: settings.cacheUrl,
            ),
          )..fetchAllTransactions(account.activeWalletAddress),
        ),
      ],
      child: const TransactionsWidget(),
    );
  }
}

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountCubit>().state.account;
    if (account == null) {
      return const Center(
        child: Text('No account selected'),
      );
    }
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 3,
              child: RefreshIndicator(
                onRefresh: () => context
                    .read<TransactionsCubit>()
                    .fetchAllTransactions(account.activeWalletAddress),
                child: StickyGroupedListView<Transaction, DateTime>(
                  stickyHeaderBackgroundColor: Colors.grey.shade800,
                  elements: state.transactions.data,
                  groupBy: (tx) => tx.dateBlock,
                  groupSeparatorBuilder: (tx) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(DateFormat('d/M/yy').format(tx.dateBlock)),
                  ),
                  itemBuilder: (context, tx) =>
                      TransactionWidget(transaction: tx),
                  itemScrollController:
                      GroupedItemScrollController(), // optional
                  order: StickyGroupedListOrder.DESC, // optional
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
