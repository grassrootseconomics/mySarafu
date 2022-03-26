// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/data/model/transaction.dart';
import 'package:my_sarafu/data/transactions_repository.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'transactions_state.dart';

class TransactionsCubit extends HydratedCubit<TransactionsState> {
  TransactionsCubit(this._transactionsRepository)
      : super(const TransactionsInitial(
            transactions: TransactionList(data: [], low: 0, high: 0)));
  final TransactionsRepository _transactionsRepository;

  Future<void> fetchAllTransactions(EthereumAddress address) async {
    log.d("Fetching");
    try {
      final transactions = await _transactionsRepository.getAllTransactions();
      log.d('${transactions.data.length} Transactions loaded');
      emit(TransactionsLoaded(transactions: transactions));
    } catch (e) {
      log.e(e);
    }
  }

  @override
  TransactionsState fromJson(dynamic json) {
    try {
      final transactions = TransactionList.fromJson(json);
      print(transactions);
      return TransactionsLoaded(transactions: transactions);
    } catch (e) {
      log.e(e);
    }

    return TransactionsInitial(
        transactions: TransactionList(data: [], low: 0, high: 0));
  }

  @override
  Map<String, Object> toJson(TransactionsState state) {
    return state.transactions.toJson();
  }
}
