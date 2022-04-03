part of 'tokens_cubit.dart';

@immutable
abstract class TokensState extends Equatable {
  const TokensState({required this.tokens, this.activeTokenIdx});
  final List<TokenItem> tokens;
  final int? activeTokenIdx;
}

class TokensInitial extends TokensState {
  const TokensInitial({required List<TokenItem> tokens, int? activeTokenIdx})
      : super(tokens: tokens, activeTokenIdx: activeTokenIdx);

  @override
  get props {
    return [...tokens];
  }
}

class TokensLoaded extends TokensState {
  const TokensLoaded({required List<TokenItem> tokens, int? activeTokenIdx})
      : super(tokens: tokens, activeTokenIdx: activeTokenIdx);

  @override
  List<Object?> get props {
    return [...tokens, activeTokenIdx];
  }

  TokensLoaded copyWith({
    List<TokenItem>? tokens,
    int? activeTokenIdx,
  }) {
    return TokensLoaded(
      tokens: tokens ?? this.tokens,
      activeTokenIdx: activeTokenIdx ?? this.activeTokenIdx,
    );
  }
}

class TokensError extends TokensState {
  const TokensError(
      List<TokenItem> tokens, int? activeTokenIdx, this.message)
      : super(tokens: tokens, activeTokenIdx: activeTokenIdx);
  final String message;

  @override
  get props => [...tokens, message, activeTokenIdx];
}
