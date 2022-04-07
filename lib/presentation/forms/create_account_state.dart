part of 'create_account_cubit.dart';

@immutable
abstract class CreateAccountFormState extends Equatable {
  const CreateAccountFormState();
}

class EmptyAccountFormState extends CreateAccountFormState {
  const EmptyAccountFormState() : super();
  @override
  get props {
    return [];
  }
}

class CreatingAccountFormState extends CreateAccountFormState {
  const CreatingAccountFormState({
    required this.name,
    required this.password,
    required this.passwordConfirmation,
  }) : super();
  final String name;
  final String password;
  final String passwordConfirmation;

  @override
  get props {
    return [name, password, passwordConfirmation];
  }
}

class DirtyAccountFormState extends CreateAccountFormState {
  const DirtyAccountFormState({
    this.name,
    this.password,
    this.passwordConfirmation,
  }) : super();
  final String? name;
  final String? password;
  final String? passwordConfirmation;

  @override
  get props {
    return [name, password, passwordConfirmation];
  }
}

class CreatedAccountState extends CreateAccountFormState {
  const CreatedAccountState({
    required this.account,
  }) : super();
  final Account account;

  @override
  get props {
    return [account];
  }
}

class ErrorAccountFormState extends CreateAccountFormState {
  const ErrorAccountFormState({
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
  get props => [name, password, passwordConfirmation, message];
}
