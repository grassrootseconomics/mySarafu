import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/cubits/accounts/accounts_cubit.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../helpers/mocks.dart';

void main() {
  group('AccountsCubit', () {
    test('equality', () {
      mockHydratedStorage(() {
        expect(
          AccountsCubit().state,
          AccountsCubit().state,
        );
      });
    });
    group('toJson/fromJson', () {
      test('AccountsEmpty', () {
        mockHydratedStorage(() {
          final accountsCubit = AccountsCubit();
          expect(
            accountsCubit.fromJson(accountsCubit.toJson(accountsCubit.state)),
            accountsCubit.state,
          );
        });
      });
      test('AccountsLoaded', () {
        mockHydratedStorage(() {
          final accountsCubit = AccountsCubit()
            ..addAccount(mockAccount)
            ..addAccount(mockAccount2);
          expect(
            accountsCubit.state,
            AccountsLoaded(
              accounts: [mockAccount, mockAccount2],
              activeAccountIdx: 1,
            ),
          );
          expect(
            accountsCubit.fromJson(accountsCubit.toJson(accountsCubit.state)),
            accountsCubit.state,
          );
        });
      });
    });
    group('operations', () {
      late AccountsCubit accountsCubit;

      setUp(() async {
        accountsCubit = await mockHydratedStorage(
          AccountsCubit.new,
        );
      });

      blocTest<AccountsCubit, AccountsState>(
        'addAccount, addAccount, deleteAccount',
        build: () => accountsCubit,
        act: (cubit) => cubit
          ..addAccount(mockAccount)
          ..addAccount(mockAccount2)
          ..deleteAccount(1, password: 'test'),
        expect: () => <AccountsState>[
          AccountsLoaded(accounts: [mockAccount], activeAccountIdx: 0),
          AccountsLoaded(
            accounts: [mockAccount, mockAccount2],
            activeAccountIdx: 1,
          ),
          AccountsLoaded(accounts: [mockAccount], activeAccountIdx: 0)
        ],
      );

      blocTest<AccountsCubit, AccountsState>(
        'createAccount',
        build: () => accountsCubit,
        act: (cubit) =>
            cubit..createAccount(name: 'create_test', password: 'test'),
        expect: () => [
          isA<AccountsLoaded>(),
        ],
      );
    });
  });
}
