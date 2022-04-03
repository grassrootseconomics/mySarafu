import 'dart:math'; //used for the random number generator

import 'package:web3dart/web3dart.dart';

// In either way, the library can derive the public key and the address
// from a private key:
Wallet createWallet() {
  final rng = Random.secure();
  final credentials = EthPrivateKey.createRandom(rng);
  final wallet = Wallet.createNew(credentials, 'password', rng);
  return wallet;
}

Wallet unlockWallet(String walletJson, String password) {
  final wallet = Wallet.fromJson(walletJson, password);
  return wallet;
}
