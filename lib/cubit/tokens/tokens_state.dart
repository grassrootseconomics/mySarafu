part of 'tokens_cubit.dart';

@immutable
abstract class TokensState extends Equatable {
  const TokensState({required this.tokens, this.activeToken});
  final List<TokenItem> tokens;
  final TokenItem? activeToken;

}

class TokensInitial extends TokensState {
  const TokensInitial({required List<TokenItem> tokens, TokenItem? activeToken})
      : super(tokens: tokens, activeToken: activeToken);

  @override
  get props {
    return [...tokens];
  }
}

class TokensLoaded extends TokensState {
  const TokensLoaded({required List<TokenItem> tokens, TokenItem? activeToken})
      : super(tokens: tokens, activeToken: activeToken);

  @override
  List<Object?> get props {
    return [...tokens, activeToken];
  }
  TokensLoaded copyWith({
    List<TokenItem>? tokens,
    TokenItem? activeToken,
  }) {
    return TokensLoaded(
      tokens: tokens ?? this.tokens,
      activeToken: activeToken ?? this.activeToken,
    );
  }
  
}

class TokensError extends TokensState {
  const TokensError(
      List<TokenItem> tokens, TokenItem? activeToken, this.message)
      : super(tokens: tokens, activeToken: activeToken);
  final String message;

  @override
  get props => [...tokens, message,activeToken];
}
