// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/model/state.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/logic/data/tokens_repository.dart';
import 'package:my_sarafu/logic/data/transactions_repository.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<Settings> {
  AppCubit(this._transactionsRepository, this._tokenRepository)
      : super(AppStateInitial());

  final TransactionsRepository _transactionsRepository;
  final TokenRepository _tokenRepository;
  @override
  Settings fromJson(Map<String, dynamic> json) => Settings(
        chainSpec: json['chainSpec'] as String,
        route: json['route'] as String,
        contractRegisteryAddress: json['contractRegisteryAddress'] as String,
        tokenRegistryAddress: json['tokenRegistryAddress'] as String,
        metaUrl: json['metaUrl'] as String,
        cacheUrl: json['cacheUrl'] as String,
        rpcProvider: json['rpcProvider'] as String,
        tokens: TokenList.fromJson(json['tokens'] as List),
        activeToken: TokenItem.fromJson(json['activeToken']),
        encryptedWallet: jsonDecode(json['wallet'] as String) as String,
      );

  @override
  Map<String, Object> toJson(Settings appState) {
    return {
      'chainSpec': appState.chainSpec,
      'route': appState.route,
      'contractRegisteryAddress': appState.contractRegisteryAddress,
      'tokenRegistryAddress': appState.tokenRegistryAddress ?? '',
      'cacheUrl': appState.cacheUrl,
      'metaUrl': appState.metaUrl,
      'rpcProvider': appState.rpcProvider,
      'tokens': appState.tokens.toJson(),
      'activeToken': appState.activeToken ?? '',
      'encryptedWallet': jsonEncode(appState.encryptedWallet),
    };
  }

  void setSettings(Settings newSettings) => emit(newSettings);
}
