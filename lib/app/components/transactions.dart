import 'package:flutter/material.dart';
import 'package:my_sarafu/app/components/transaction.dart';

/// Displays a list of SampleItems.
class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget(
      {Key? key,
      this.transactions = const [
        TransactionItem(1, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(2, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(3, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(4, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(5, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(6, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(7, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(8, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(9, 'William', 'Sam', 0.00, 'SRF'),
        TransactionItem(10, 'William', 'Sam', 0.00, 'SRF')
      ]})
      : super(key: key);

  final List<TransactionItem> transactions;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: ListView.builder(
            // Providing a restorationId allows the ListView to restore the
            // scroll position when a user leaves and returns to the app after it
            // has been killed while running in the background.
            restorationId: 'sampleItemListView',
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = transactions[index];

              return TransactionWidget(transaction: transaction);
            },
          ),
        ),
      ),
    );
  }
}
