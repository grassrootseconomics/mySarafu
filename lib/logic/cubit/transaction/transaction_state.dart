part of 'transaction_cubit.dart';

@immutable
abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial() : super();
  @override
  List<Object?> get props {
    return [];
  }
}
class TransactionReady extends TransactionState {
  const TransactionReady() : super();

  @override
  List<Object?> get props {
    return [];
  }
}
class TransactionSending extends TransactionReady {
  const TransactionSending() : super();
  @override
  List<Object?> get props {
    return [];
  }
}

class TransactionSent extends TransactionSending {
  const TransactionSent() : super();

  @override
  List<Object?> get props {
    return [];
  }
}

class TransactionError extends TransactionState {
  const TransactionError(this.message) : super();
  final String message;

  @override
  List<Object?> get props => [message];
}
