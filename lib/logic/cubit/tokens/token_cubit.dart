import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/meta_repository.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/logic/utils/logger.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit({required this.metaRespository, required this.token})
      : super(TokenInitial(token: token));
  final MetaRepository metaRespository;
  final Token token;

  Future<void> fetchMeta() async {
    log.d('Getting Meta for ${token.symbol}');
    if (state is TokenLoaded) {
      emit(
        TokenLoading(
            token: token,
            meta: (state as TokenLoaded).meta,
            proof: (state as TokenLoaded).proof),
      );
    }
    if (state is TokenLoading) {
      return;
    }
    if (state is TokenInitial) {
      emit(TokenLoading(token: token));
    }

    final vouncherInfo = await metaRespository.tokenMetaSymbol(token.symbol);
    final proofs = await metaRespository.tokenProofSymbol(token.symbol);
    emit(
      TokenLoaded(token: token, meta: vouncherInfo, proof: proofs),
    );
  }
}
