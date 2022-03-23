part of 'tokens_cubit.dart';



@immutable
abstract class TokensState {
  const TokensState();
}

class TokensInitial extends TokensState {
  const TokensInitial();
}

class TokensLoading extends TokensState {
  const TokensLoading();
}


class TokensLoaded extends TokensState {
  final List<TokenItem> tokens;
  const TokensLoaded(this.tokens): super();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TokensLoaded && o.tokens == tokens;
  }

  @override
  int get hashCode => tokens.hashCode;
}

class TokensError extends TokensState {
  final String message;
  TokensError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TokensError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}