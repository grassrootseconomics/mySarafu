import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/logic/data/tokens_repository.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

part 'tokens_state.dart';

class TokensCubit extends HydratedCubit<TokensState> {
  TokensCubit(this._tokenRepository) : super(const TokensLoaded(tokens: []));
  final TokenRepository _tokenRepository;

  Future<void> fetchAllTokens(EthereumAddress address) async {
    log.d('Getting tokens for $address');
    final tokens = await _tokenRepository.getAllTokens(address);
    log.d('${tokens.length} Tokens loaded');
    emit(
      TokensLoaded(
        tokens: tokens,
        activeTokenIdx: state.activeTokenIdx ?? 0,
      ),
    );
  }

  Token? get activeToken {
    if (state.activeTokenIdx is int &&
        state.tokens.length > state.activeTokenIdx!) {
      return state.tokens[state.activeTokenIdx!];
    }
    return null;
  }

  Future<void> updateBalances(EthereumAddress address) async {
    log.d('Updating balances for $address for ${state.tokens.length} Tokens');
    final updated =
        await _tokenRepository.updateBalances(address, state.tokens);
    log.d('Updated Balances for ${updated.length} Tokens');
    emit(TokensLoaded(tokens: updated, activeTokenIdx: state.activeTokenIdx));
  }

  @override
  TokensState fromJson(Map<String, dynamic> json) {
    try {
      final tokens = <Token>[];
      for (final dToken in json['tokens']) {
        final token = Token.fromJson(dToken);
        tokens.add(token);
      }
      final activeTokenIdx =
          json['activeTokenIdx'] != null ? json['activeTokenIdx'] as int : 0;
      return TokensLoaded(tokens: tokens, activeTokenIdx: activeTokenIdx);
    } catch (e) {
      log.e(e);
    }

    return const TokensInitial(tokens: []);
  }

  @override
  Map<String, Object> toJson(TokensState state) {
    final data = {
      'tokens':
          state.tokens.map<Map<String, String>>((t) => t.toJson()).toList(),
      'activeTokenIdx': 0,
    };
    return data;
  }
}
