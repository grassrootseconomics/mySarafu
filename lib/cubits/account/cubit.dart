import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/model/db/account.dart';
import 'package:my_sarafu/model/network_presets.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(const NoAccountState());

  void createAccount({
    required String name,
    required String password,
    required String passwordConfirmation,
  }) {
    if (name.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
      emit(
        InvalidAccountState(
          name: name,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      return;
    }
    if (password != passwordConfirmation) {
      emit(
        ErrorAccountState(
          name: name,
          password: password,
          passwordConfirmation: passwordConfirmation,
          message: 'Passwords do not match',
        ),
      );
      return;
    }
    log.d('Creating account');

    emit(
      CreatingAccountState(
        name: name,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
    final rng = Random.secure();
    final credentials = EthPrivateKey.createRandom(rng);
    final wallet = Wallet.createNew(credentials, password, rng);
    final address = wallet.privateKey.address;
    final encryptedWallet = wallet.toJson();
    final account = Account(
      encryptedWallet: encryptedWallet,
      name: name,
      address: address,
      activeVoucher: mainnet.defaultVoucherAddress,
      balance: "",
    );
    log.d('Created account $account');

    emit(CreatedAccountState(account: account));
  }
}
//  wallet: jsonDecode(json['wallet'] as String) as String,
//       password: json['password'] as String,
