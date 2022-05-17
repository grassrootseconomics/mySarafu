part of 'cubit.dart';

@immutable
abstract class AccountState extends Equatable {
  const AccountState({this.account});
  final Account? account;
}

class NoAccountState extends AccountState {
  const NoAccountState() : super();

  @override
  List<Object?> get props {
    return [];
  }
}

class CreatingAccountState extends AccountState {
  const CreatingAccountState({
    required this.name,
    required this.password,
    required this.passwordConfirmation,
  }) : super();
  final String name;
  final String password;
  final String passwordConfirmation;

  @override
  List<Object?> get props {
    return [name, password, passwordConfirmation];
  }
}

class InvalidAccountState extends AccountState {
  const InvalidAccountState({
    this.name,
    this.password,
    this.passwordConfirmation,
  }) : super();
  final String? name;
  final String? password;
  final String? passwordConfirmation;

  @override
  List<Object?> get props {
    return [name, password, passwordConfirmation];
  }
}

class CreatedAccountState extends AccountState {
  const CreatedAccountState({
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
    this.name,
    this.password,
    this.passwordConfirmation,
    required this.message,
  }) : super();
  final String message;
  final String? name;
  final String? password;
  final String? passwordConfirmation;

  @override
  List<Object?> get props => [name, password, passwordConfirmation, message];
}
