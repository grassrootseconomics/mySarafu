// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/data/model/token.dart';
import 'package:my_sarafu/data/tokens_repository.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'tokens_state.dart';

class TokensCubit extends Cubit<TokensState> {
  TokensCubit(this._tokenRepository) : super(const TokensInitial());
  final TokenRepository _tokenRepository;

  Future<void> fetchAllTokens(EthereumAddress address) async {
    log.d('Getting tokens for $address');
    emit(TokensLoading());
    final tokens = await _tokenRepository.getAllTokens(address);
    log.d('${tokens.length} Tokens loaded');
    emit(TokensLoaded(tokens));
    // ignore: avoid_catching_errors
  }

  Future<void> updateBalances(
      EthereumAddress address, List<TokenItem> tokens) async {
    try {
      emit(TokensLoading());
      log.d('Updating balances for $address');
      final updated = await _tokenRepository.updateBalances(tokens);
      log.d('Balances updated');
      emit(TokensLoaded(updated));
      // ignore: avoid_catching_errors
    } on Error {
      emit(
        TokensError(
          "Couldn't update balances. Is the device online?",
        ),
      );
    }
  }
}
