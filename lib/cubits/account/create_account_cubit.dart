import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/data/model/account.dart';
import 'package:my_sarafu/data/network_presets.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'create_account_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  CreateAccountFormCubit() : super(const EmptyAccountFormState());

  void createAccount({
    required String name,
    required String password,
    required String passwordConfirmation,
  }) {
    if (name.isEmpty) {
      emit(
        DirtyAccountFormState(
          name: name,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      return;
    }
    if (password.isEmpty) {
      emit(
        DirtyAccountFormState(
          name: name,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      return;
    }
    if (passwordConfirmation.isEmpty) {
      emit(
        DirtyAccountFormState(
          name: name,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      );
      return;
    }
    if (password != passwordConfirmation) {
      emit(
        ErrorAccountFormState(
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
      CreatingAccountFormState(
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
    );
    log.d('Created account $account');

    emit(CreatedAccountState(account: account));
  }
}
//  wallet: jsonDecode(json['wallet'] as String) as String,
//       password: json['password'] as String,
