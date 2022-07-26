// ignore_for_file: overridden_fields

part of 'cubit.dart';

class AccountState extends Equatable {
  const AccountState({this.account});
  final Account? account;

  AccountState copyWith({
    Account? account,
  }) {
    return AccountState(
      account: account ?? this.account,
    );
  }

  @override
  List<Object?> get props {
    return [account];
  }
}

class NoAccountState extends AccountState {
  const NoAccountState() : super();

  @override
  List<Object?> get props {
    return [];
  }
}

class UnverifiedAccountState extends AccountState {
  const UnverifiedAccountState({
    required this.account,
  }) : super();
  @override
  final Account account;

  @override
  List<Object?> get props {
    return [account];
  }
}

class InvalidAccountState extends AccountState {
  const InvalidAccountState() : super();
  @override
  List<Object?> get props {
    return [];
  }
}

class VerifiedAccountState extends AccountState {
  const VerifiedAccountState({
    required this.account,
  }) : super();
  @override
  final Account account;

  @override
  List<Object?> get props {
    return [account];
  }
}

class ErrorAccountState extends AccountState {
  const ErrorAccountState({
    this.account,
    required this.message,
  }) : super();
  final String message;
  @override
  final Account? account;

  @override
  List<Object?> get props => [account, message];
}
