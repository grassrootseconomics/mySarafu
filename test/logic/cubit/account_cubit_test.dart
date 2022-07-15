import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:my_sarafu/cubits/account/cubit.dart';
import 'package:my_sarafu/repository/vault_repository.dart';

import 'account_cubit_test.mocks.dart';

@GenerateMocks([VaultRepository])
void main() {
  VaultRepository vaultRepository = MockVaultRepository();

  group('AccountCubit', () {
    test('equality', () {
      expect(
        AccountCubit(vaultRepository: vaultRepository).state,
        AccountCubit(vaultRepository: vaultRepository).state,
      );
    });
    group('operations', () {
      blocTest<AccountCubit, AccountState>(
        'createAccount emits UnverifiedAccountState',
        build: () => AccountCubit(vaultRepository: vaultRepository),
        act: (cubit) => cubit.createAccount(
          name: 'test',
          mnumonic: 'test',
          pin: 'test',
        ),
        expect: () => [isA<UnverifiedAccountState>()],
      );

      blocTest<AccountCubit, AccountState>(
        'createAccount(mismatch passwords) emits ErrorAccountState',
        build: AccountCubit.new,
        act: (cubit) => cubit.createAccount(
          name: 'test',
          password: 'test',
          passwordConfirmation: 'tes',
        ),
        expect: () => [
          const ErrorAccountState(
            name: 'test',
            password: 'test',
            passwordConfirmation: 'tes',
            message: 'Passwords do not match',
          )
        ],
      );
      blocTest<AccountCubit, AccountState>(
        'createAccount(invalid) emits InvalidAccountState',
        build: AccountCubit.new,
        act: (cubit) => cubit.createAccount(
          name: '',
          password: '',
          passwordConfirmation: '',
        ),
        expect: () => [
          const InvalidAccountState(
            name: '',
            password: '',
            passwordConfirmation: '',
          )
        ],
      );
    });
  });
}
