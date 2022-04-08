part of 'transaction_cubit.dart';

@immutable
abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial() : super();
  get props {
    return [];
  }
}
class TransactionReady extends TransactionState {
  const TransactionReady() : super();

  get props {
    return [];
  }
}
class TransactionSending extends TransactionReady {
  const TransactionSending() : super();
  get props {
    return [];
  }
}

class TransactionSent extends TransactionSending {
  const TransactionSent() : super();

  get props {
    return [];
  }
}

class TransactionError extends TransactionState {
  TransactionError(this.message) : super();
  final String message;

  get props => [message];
}
