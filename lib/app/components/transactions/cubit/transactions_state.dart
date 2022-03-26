part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState extends Equatable {
  final TransactionList transactions;
  const TransactionsState({required this.transactions});
}

class TransactionsInitial extends TransactionsState {
  final TransactionList transactions;
  const TransactionsInitial({required this.transactions})
      : super(transactions: transactions);
  get props {
    return [...transactions.data];
  }
}

class TransactionsLoading extends TransactionsState {
  final TransactionList transactions;
  const TransactionsLoading({required this.transactions})
      : super(transactions: transactions);
  get props {
    return [...transactions.data];
  }
}

class TransactionsLoaded extends TransactionsState {
  final TransactionList transactions;
  const TransactionsLoaded({required this.transactions})
      : super(transactions: transactions);

  get props {
    return [...transactions.data];
  }
}

class TransactionsError extends TransactionsState {
  final String message;
  final TransactionList transactions;

  TransactionsError(this.transactions, this.message)
      : super(transactions: transactions);

  get props => [...transactions.data, message];
}
