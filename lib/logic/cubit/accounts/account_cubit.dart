// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/utils/contracts.dart';

class Account {

  Account({
    required this.name,
    required this.wallet,
    required this.password,
  });
  final String name;
  final String wallet;
  final String password;
}

var DefaultWallet = Account(
    name: 'Account 1', wallet: createWallet().toJson(), password: 'password');

class AccountCubit extends HydratedCubit<Account> {
  AccountCubit() : super(DefaultWallet);

  @override
  Account fromJson(Map<String, dynamic> json) => Account(
        name: json['name'] as String,
        wallet: jsonDecode(json['wallet'] as String) as String,
        password: json['password'] as String,
      );

  @override
  Map<String, String> toJson(Account accountState) {
    return {
      'name': accountState.name,
      'wallet': json.encode(accountState.wallet),
      'password': accountState.password,
    };
  }

  void setSettings(Account newSettings) => emit(newSettings);
}
