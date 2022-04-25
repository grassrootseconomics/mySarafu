part of 'accounts_cubit.dart';


@immutable
abstract class AccountsState extends Equatable {
  const AccountsState({required this.accounts, this.activeAccountIdx});
  final List<Account> accounts;
  final int? activeAccountIdx;
}

class AccountsEmpty extends AccountsState {
  const AccountsEmpty() : super(accounts: const [], activeAccountIdx: 0);

  @override
  List<Object?> get props {
    return [];
  }
}

class AccountsLoaded extends AccountsState {
  const AccountsLoaded({required List<Account> accounts, int? activeAccountIdx})
      : super(accounts: accounts, activeAccountIdx: activeAccountIdx);

  @override
  List<Object?> get props {
    return [...accounts, activeAccountIdx];
  }

  AccountsLoaded copyWith({
    List<Account>? accounts,
    int? activeAccountIdx,
  }) {
    return AccountsLoaded(
      accounts: accounts ?? this.accounts,
      activeAccountIdx: activeAccountIdx ?? this.activeAccountIdx,
    );
  }
}

class AccountsError extends AccountsState {
  const AccountsError(List<Account> accounts, int? activeAccountIdx, this.message)
      : super(accounts: accounts, activeAccountIdx: activeAccountIdx);
  final String message;

  @override
  List<Object?> get props => [...accounts, message, activeAccountIdx];
}
