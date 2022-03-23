// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_sarafu/data/model/token.dart';
import 'package:my_sarafu/data/tokens_repository.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'tokens_state.dart';

class TokensCubit extends Cubit<TokensState> {
  final TokenRepository _tokenRepository;

  TokensCubit(this._tokenRepository) : super(TokensInitial());

  Future<void> getTokens(EthereumAddress address) async {
    try {
      emit(TokensLoading());
      log.d("Getting tokens for $address");
      final tokens = await _tokenRepository.getTokens(address);
      log.d("Tokens loaded");
      emit(TokensLoaded(tokens));
    } on Error {
      emit(TokensError("Couldn't fetch tokens. Is the device online?"));
    }
  }
}
