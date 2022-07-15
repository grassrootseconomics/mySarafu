import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/model/account.dart';
import 'package:my_sarafu/model/network_presets.dart';
import 'package:my_sarafu/repository/vault_repository.dart';
import 'package:my_sarafu/utils/hdwallet.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:my_sarafu/utils/service_locator.dart';

part 'state.dart';

class AccountCubit extends HydratedCubit<AccountState> {
  AccountCubit({required this.vaultRepository}) : super(const NoAccountState());
  final VaultRepository vaultRepository;

  Future<void> createAccount({
    required String name,
    required String mnumonic,
    required String pin,
    bool backup = false,
  }) async {
    final notValid = !validateMnemonic(mnumonic);
    if (notValid) {
      emit(const ErrorAccountState(message: 'Invalid mnemonic'));
      return;
    }
    final vault = sl.get<VaultRepository>();
    final mnemonic = generateMnemonic();
    await vault.writePin(pin);
    await vault.setSeed(mnemonic);
    final chain = createChain(mnemonic);
    final address = await getAddress(chain, 0);
    final account = Account(
      walletAddresses: [address],
      name: name,
      activeVoucher: mainnet.defaultVoucherAddress,
    );
    log.d('Created account $account');

    emit(UnverifiedAccountState(account: account));
  }

  @override
  AccountState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const NoAccountState();
    final accountJson = json['account'] as Map<String, dynamic>;
    if (json['verified'] == true) {
      return VerifiedAccountState(account: Account.fromJson(accountJson));
    } else {
      return UnverifiedAccountState(account: Account.fromJson(accountJson));
    }
  }

  @override
  Map<String, dynamic>? toJson(AccountState state) {
    if (state is UnverifiedAccountState) {
      return <String, dynamic>{
        'account': state.account.toJson(),
        'verified': false,
      };
    }
    return null;
  }
}
