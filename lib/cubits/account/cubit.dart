import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mysarafu/model/account.dart';
import 'package:mysarafu/model/network_presets.dart';
import 'package:mysarafu/model/voucher.dart';
import 'package:mysarafu/repository/vault_repository.dart';
import 'package:mysarafu/utils/hdwallet.dart';
import 'package:mysarafu/utils/logger.dart';

part 'state.dart';

class AccountCubit extends HydratedCubit<AccountState> {
  AccountCubit({required this.vaultRepository}) : super(const NoAccountState());
  final VaultRepository vaultRepository;

  Future<void> createAccount({
    required String mnumonic,
    required String pin,
    bool backup = false,
  }) async {
    final notValid = !validateMnemonic(mnumonic);
    if (notValid) {
      emit(const ErrorAccountState(message: 'Invalid mnemonic'));
      return;
    }
    final mnemonic = generateMnemonic();
    await vaultRepository.writePin(pin);
    await vaultRepository.setSeed(mnemonic);
    final chain = createChain(mnemonic);
    final address = await getAddress(chain, 0);
    final account = Account(
      walletAddresses: [address],
      activeVoucher: mainnet.defaultVoucherAddress,
    );
    log.d('Created account $account');

    emit(UnverifiedAccountState(account: account));
  }

  bool get hasAccount => state.account != null;

  bool get isVerified => state.account?.verified ?? false;

  Future<void> setDefaultVoucher({
    required Voucher voucher,
  }) async {
    if (!hasAccount) {
      emit(const ErrorAccountState(message: 'No account'));
      return;
    }
    emit(
      state.copyWith(
        account: state.account?.copyWith(activeVoucher: voucher.address),
      ),
    );
  }

  Future<void> verifyAccount({
    String? phoneNumber,
    String? email,
    required String otp,
  }) async {
    emit(VerifiedAccountState(account: state.account!));
  }

  @override
  AccountState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const NoAccountState();
    final accountJson = json['account'] as Map<String, dynamic>;
    final account = Account.fromJson(accountJson);
    if (account.verified) {
      return VerifiedAccountState(account: account);
    }
    return UnverifiedAccountState(account: account);
  }

  @override
  Map<String, dynamic>? toJson(AccountState state) {
    if (state.account == null) return null;
    return <String, dynamic>{
      'account': state.account!.toJson(),
    };
  }
}
