import 'package:flutter/material.dart';

import 'icon.dart';

class TransactionItem {
  const TransactionItem(this.id, this.from, this.to, this.amount, this.symbol);
  final int id;
  final String from;
  final String to;
  final double amount;
  final String symbol;
}

const address = "e451221d403ad317f2fa77d01ac1ec1ba82ce22f";

/// Displays a list of SampleItems.
class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
    this.transaction = const TransactionItem(1, 'William', 'Sam', 0.00, 'SRF'),
  }) : super(key: key);

  final TransactionItem transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: IconWidget(),
          ),
          Expanded(
            child: Text(transaction.from),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '${transaction.amount.toString()} ${transaction.symbol}',
                  textAlign: TextAlign.end),
            ),
          ),
        ],
      ),
    );
  }
}
