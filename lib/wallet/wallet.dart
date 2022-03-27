import 'dart:convert';
import 'dart:math'; //used for the random number generator
import 'dart:typed_data';

import 'package:my_sarafu/contracts/contract-registery/contract.g.dart';
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

class RegisteryProvider {
  RegisteryProvider({required this.contractRegistery, required this.client})
      : contract = RegisteryContract(
          address: EthereumAddress.fromHex(contractRegistery),
          client: client,
        );
  final String contractRegistery;
  final Web3Client client;
  final RegisteryContract contract;

  Future<EthereumAddress> getTokenRegistery() async {
    return contract.addressOf(fromText('TokenRegistry'));
  }

  Future<EthereumAddress> getAccountRegistery() async {
    return contract.addressOf(fromText('AccountRegistry'));
  }

  Future<EthereumAddress> getFaucet() async {
    return contract.addressOf(fromText('Faucet'));
  }

  Future<EthereumAddress> getAddressDeclarator() async {
    return contract.addressOf(fromText('AddressDeclarator'));
  }

  Future<EthereumAddress> getTransferAuthorization() async {
    return contract.addressOf(fromText('TransferAuthorization'));
  }

  Future<EthereumAddress> getContractRegistery() async {
    return contract.addressOf(fromText('ContractRegistry'));
  }

  Future<EthereumAddress> getDefaultToken() async {
    return contract.addressOf(fromText('DefaultToken'));
  }
}

Uint8List fromText(String identifier) {
  final bytes = Uint8List.fromList(utf8.encode(identifier));
  final padded = bytes + Uint8List(32 - bytes.length);
  return Uint8List.fromList(padded);
}
