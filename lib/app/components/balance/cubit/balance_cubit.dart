// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

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
