import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mysarafu/model/transaction.dart';
import 'package:mysarafu/repository/cache_repository.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'transactions_state.dart';

class TransactionsCubit extends HydratedCubit<TransactionsState> {
  TransactionsCubit(this._transactionsRepository)
      : super(
          const TransactionsInitial(
            transactions: TransactionList(data: [], low: 0, high: 0),
          ),
        );
  final CacheRepository _transactionsRepository;

  Future<void> fetchAllTransactions(EthereumAddress address) async {
    try {
      final transactions = await _transactionsRepository.getAllTransactions();
      emit(TransactionsLoaded(transactions: transactions));
    } catch (e) {
      log.e(e);
    }
  }

  @override
  TransactionsState fromJson(Map<String, dynamic> json) {
    try {
      final transactions = TransactionList.fromJson(json);
      return TransactionsLoaded(transactions: transactions);
    } catch (e) {
      log.e(e);
    }

    return const TransactionsInitial(
      transactions: TransactionList(data: [], low: 0, high: 0),
    );
  }

  @override
  Map<String, Object> toJson(TransactionsState state) {
    return state.transactions.toJson();
  }
}
