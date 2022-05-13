import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/cubit/transactions/transactions_cubit.dart';
import 'package:my_sarafu/logic/data/cache_repository.dart';
import 'package:my_sarafu/logic/data/model/transaction.dart';
import 'package:my_sarafu/presentation/widgets/transactions/transaction.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final account = context.read<AccountsCubit>().activeAccount;
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
              address: account.address,
              cacheUrl: settings.cacheUrl,
            ),
          )..fetchAllTransactions(account.address),
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
    final account = context.read<AccountsCubit>().activeAccount;
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
                    .fetchAllTransactions(account.address),
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
