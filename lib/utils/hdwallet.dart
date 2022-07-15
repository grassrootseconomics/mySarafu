import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web3dart/web3dart.dart';

String generateMnemonic() {
  return bip39.generateMnemonic();
}

bool validateMnemonic(String mnemonic) {
  return bip39.validateMnemonic(mnemonic);
}

Chain createChain(String mnemonic) {
  final chain = Chain.seed(hex.encode(utf8.encode(mnemonic)));
  return chain;
}

Future<EthereumAddress> getAddress(
  Chain chain,
  int index,
) async {
  final credentials = getCredentials(chain, index);
  final address = await credentials.extractAddress(); //web3dart
  return address;
}

Future<List<EthereumAddress>> getAllAddresses(
  Chain chain,
  int count,
) async {
  final addresses = <EthereumAddress>[];
  for (var i = 0; i < count; i++) {
    final key = chain.forPath("m/44'/60'/0'/0/$i");
    final Credentials credentials = EthPrivateKey.fromHex(key.privateKeyHex());
    final address = await credentials.extractAddress(); //web3dart
    addresses.add(address);
  }
  return addresses;
}

Credentials getCredentials(
  Chain chain,
  int index,
) {
  final key = chain.forPath("m/44'/60'/0'/0/$index");
  final Credentials credentials = EthPrivateKey.fromHex(key.privateKeyHex());
  return credentials;
}
