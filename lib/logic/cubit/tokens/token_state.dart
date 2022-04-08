part of 'token_cubit.dart';

@immutable
abstract class TokenState extends Equatable {
  const TokenState({required this.token});
  final Token token;
}

class TokenInitial extends TokenState {
  const TokenInitial({required Token token}) : super(token: token);

  @override
  get props {
    return [token];
  }
}

class TokenLoading extends TokenState {
  const TokenLoading({
    required Token token,
    this.meta,
    this.proof,
  }) : super(token: token);

  final VoucherIssuer? meta;
  final VoucherProof? proof;

  @override
  get props {
    return [meta, proof, token];
  }
}

class TokenLoaded extends TokenState {
  const TokenLoaded({
    required Token token,
    required this.meta,
    required this.proof,
  }) : super(token: token);
  final VoucherIssuer meta;
  final VoucherProof proof;

  @override
  List<Object?> get props {
    return [meta, proof, token];
  }

  TokenLoaded copyWith({
    Token? token,
    VoucherIssuer? meta,
    VoucherProof? proof,
  }) {
    return TokenLoaded(
      token: token ?? this.token,
      meta: meta ?? this.meta,
      proof: proof ?? this.proof,
    );
  }
}

class TokenError extends TokenState {
  const TokenError(Token token, this.message) : super(token: token);
  final String message;

  @override
  get props => [token, message];
}
