part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState extends Equatable {
  const TransactionsState({required this.transactions});
  final TransactionList transactions;
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial({required TransactionList transactions})
      : super(transactions: transactions);
  @override
  List<Object?> get props {
    return [...transactions.data];
  }
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading({required TransactionList transactions})
      : super(transactions: transactions);
  @override
  List<Object?> get props {
    return [...transactions.data];
  }
}

class TransactionsLoaded extends TransactionsState {
  const TransactionsLoaded({required TransactionList transactions})
      : super(transactions: transactions);

  @override
  List<Object?> get props {
    return [...transactions.data];
  }
}

class TransactionsError extends TransactionsState {
  const TransactionsError(TransactionList transactions, this.message)
      : super(transactions: transactions);
  final String message;

  @override
  List<Object?> get props => [...transactions.data, message];
}
