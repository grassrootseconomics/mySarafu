part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState extends Equatable {
  const TransactionsState({required this.transactions});
  final TransactionList transactions;
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial({required TransactionList transactions})
      : super(transactions: transactions);
  get props {
    return [...transactions.data];
  }
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading({required TransactionList transactions})
      : super(transactions: transactions);
  get props {
    return [...transactions.data];
  }
}

class TransactionsLoaded extends TransactionsState {
  const TransactionsLoaded({required TransactionList transactions})
      : super(transactions: transactions);

  get props {
    return [...transactions.data];
  }
}

class TransactionsError extends TransactionsState {

  TransactionsError(TransactionList transactions, this.message)
      : super(transactions: transactions);
  final String message;

  get props => [...transactions.data, message];
}
