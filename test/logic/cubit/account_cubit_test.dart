import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysarafu/cubits/account/cubit.dart';
import 'package:mysarafu/model/account.dart';
import 'package:mysarafu/model/network_presets.dart';
import 'package:mysarafu/repository/vault_repository.dart';
import 'package:web3dart/credentials.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../helpers/mocks.dart';

void main() {
  final VaultRepository vaultRepository = MockVaultRepository();

  group('AccountCubit', () {
    test('equality', () {
      expect(
        AccountCubit(vaultRepository: vaultRepository).state,
        AccountCubit(vaultRepository: vaultRepository).state,
      );
    });
    group('operations', () {
      late AccountCubit accountCubit;
      setUp(() async {
        accountCubit = await mockHydratedStorage(
          () => AccountCubit(vaultRepository: vaultRepository),
        );
      });
      blocTest<AccountCubit, AccountState>(
        'createAccount emits UnverifiedAccountState',
        build: () => accountCubit,
        act: (cubit) {
          cubit.createAccount(
            mnumonic: mockMnemonic,
            pin: '000000',
          );
        },
        expect: () => [isA<UnverifiedAccountState>()],
      );

      blocTest<AccountCubit, AccountState>(
        'creates a unverified account',
        build: () => AccountCubit(vaultRepository: vaultRepository),
        act: (cubit) => cubit.createAccount(
          mnumonic: mockMnemonic,
          pin: '000000',
        ),
        expect: () => [
          UnverifiedAccountState(
            account: Account(
              activeVoucher: mainnet.defaultVoucherAddress,
              walletAddresses: <EthereumAddress>[mockAddress0],
            ),
          )
        ],
      );
    });
  });
}
