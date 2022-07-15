import 'dart:math';

import 'package:my_sarafu/model/account.dart';
import 'package:my_sarafu/model/network_presets.dart';
import 'package:web3dart/web3dart.dart';

class AccountRepository {
  AccountRepository();
  Future<Account> createAccount({
    required String name,
    required String password,
    EthereumAddress? activeVoucherAddress,
  }) async {
    final rng = Random.secure();
    final credentials = EthPrivateKey.createRandom(rng);
    final wallet = Wallet.createNew(credentials, password, rng);
    final address = wallet.privateKey.address;
    final encryptedWallet = wallet.toJson();
    final account = Account(
      name: name,
      walletAddresses: [address],
      activeChainIndex: 0,
      activeVoucher: activeVoucherAddress ?? mainnet.defaultVoucherAddress,
    );
    return account;
  }
}
