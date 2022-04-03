import 'package:bloc/bloc.dart';

class Balance {
  const Balance({
    required this.name,
    required this.symbol,
    required this.balance,
  });

  final String name;
  final String symbol;
  final double balance;
}

class BalanceCubit extends Cubit<Balance> {
  BalanceCubit()
      : super(const Balance(balance: 0, name: 'Sarafu', symbol: 'SRF'));

  void setBalance(Balance newBalance) => emit(newBalance);
}
