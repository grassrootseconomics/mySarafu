// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/utils/contracts.dart';
import 'dart:convert';

class Tokens {
  final String name;
  final String wallet;
  final String password;

  Tokens({
    required this.name,
    required this.wallet,
    required this.password,
  });
}

var DefaultWallet = Tokens(
    name: 'Account 1', wallet: createWallet().toJson(), password: 'password');

class TokensCubit extends HydratedCubit<Tokens> {
  TokensCubit() : super(DefaultWallet);

  @override
  Tokens fromJson(Map<String, dynamic> json) => Tokens(
        name: json['name'] as String,
        wallet: jsonDecode(json['wallet'] as String) as String,
        password: json['password'] as String,
      );

  @override
  Map<String, String> toJson(Tokens account) {
    return {
      'name': account.name,
      'wallet': json.encode(account.wallet),
      'password': account.password,
    };
  }

  void setSettings(Tokens newSettings) => emit(newSettings);
}
