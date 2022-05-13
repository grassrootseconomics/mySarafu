import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/model/account.dart';
import 'package:my_sarafu/logic/data/network_presets.dart';
import 'package:web3dart/web3dart.dart';

part 'accounts_state.dart';

class AccountsCubit extends HydratedCubit<AccountsState> {
  AccountsCubit() : super(const AccountsEmpty());

  void createAccount({required String name, required String password}) {
    final rng = Random.secure();
    final credentials = EthPrivateKey.createRandom(rng);
    final wallet = Wallet.createNew(credentials, password, rng);
    final address = wallet.privateKey.address;
    final encryptedWallet = wallet.toJson();
    final accounts = [
      ...state.accounts,
      Account(
        encryptedWallet: encryptedWallet,
        name: name,
        address: address,
        activeVoucher: mainnet.defaultVoucherAddress,
      )
    ];
    emit(
      AccountsLoaded(
        accounts: accounts,
        activeAccountIdx: accounts.length - 1,
      ),
    );
  }

  void setActiveAccount(int accountIdx) {
    emit(
      AccountsLoaded(
        accounts: state.accounts,
        activeAccountIdx: accountIdx,
      ),
    );
  }

  void deleteAccount(int accountIdx, {required String password}) {
    final account = state.accounts[accountIdx];
    final isOwner = account.verifyPassword(password);
    if (isOwner) {
      final accounts = [...state.accounts..removeAt(accountIdx)];
      emit(
        AccountsLoaded(
          accounts: accounts,
          activeAccountIdx: accountIdx,
        ),
      );
    }
  }

  void addAccount(Account account) {
    final newAccounts = <Account>[...state.accounts, account];
    emit(
      AccountsLoaded(
        accounts: newAccounts,
        activeAccountIdx: newAccounts.length - 1,
      ),
    );
  }

  void setActiveVoucher(EthereumAddress voucherAddress) {
    if (state is AccountsLoaded && activeAccount is Account) {
      final updatedAccounts = [...state.accounts];
      updatedAccounts[state.activeAccountIdx!] =
          activeAccount!.copyWith(activeVoucher: voucherAddress);
      emit((state as AccountsLoaded).copyWith(accounts: updatedAccounts));
    }
  }

  Account? get activeAccount => state.activeAccountIdx is int &&
          state.accounts.asMap().containsKey(state.activeAccountIdx)
      ? state.accounts[state.activeAccountIdx!]
      : null;

  @override
  AccountsState fromJson(Map<String, dynamic> json) {
    final accounts = (json['accounts'] as List<dynamic>)
        .map(Account.fromJson)
        .toList();
    return AccountsLoaded(
      accounts: accounts,
      activeAccountIdx: json['activeAccountIdx'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson(AccountsState state) {
    return <String, dynamic>{
      'accounts': state.accounts.map((e) => e.toJson()).toList(),
      'activeAccountIdx': state.activeAccountIdx,
    };
  }

  void setSettings(AccountsState newSettings) => emit(newSettings);
}
//  wallet: jsonDecode(json['wallet'] as String) as String,
//       password: json['password'] as String,
