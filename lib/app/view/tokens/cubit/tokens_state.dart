part of 'tokens_cubit.dart';

@immutable
abstract class TokensState extends Equatable {
  final List<TokenItem> tokens;
  const TokensState({required this.tokens});
}

class TokensInitial extends TokensState {
  final List<TokenItem> tokens;
  const TokensInitial({required this.tokens}) : super(tokens: tokens);
  get props {
    print("TokensInitial");
    print([...tokens]);
    return [tokens];
  }
}

class TokensLoading extends TokensState {
  final List<TokenItem> tokens;
  const TokensLoading({required this.tokens}) : super(tokens: tokens);
  get props {
    print("TokensLoading");
    print([...tokens]);
    return [tokens];
  }
}

class TokensLoaded extends TokensState {
  final List<TokenItem> tokens;
  const TokensLoaded({required this.tokens}) : super(tokens: tokens);

  get props {
    print("TokensLoaded");
    print([...tokens]);
    return [tokens];
  }
}

class TokensError extends TokensState {
  final String message;
  final List<TokenItem> tokens;

  TokensError(this.tokens, this.message) : super(tokens: tokens);

  get props => [...tokens, message];
}
