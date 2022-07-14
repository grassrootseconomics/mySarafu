import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/credentials.dart';

const mockMnemonic =
    // ignore: lines_longer_than_80_chars
    'require rain scan insect goddess weird boring fortune blast round predict sort';
final mockAddress =
    EthereumAddress.fromHex('0x44388ec850286ba772beec22088c04a0da59c32a');
void main() {
  group('Wallet', () {
    test('mnemonic generation', () async {
      final randomMnemonic = bip39.generateMnemonic();
      final isValid = bip39.validateMnemonic(randomMnemonic);
      expect(isValid, isTrue);
    });
    test('address from mnemonic', () async {
      final chain = Chain.seed(hex.encode(utf8.encode(mockMnemonic)));
      final key = chain.forPath("m/44'/60'/0'/0/0");
      final Credentials credentials =
          EthPrivateKey.fromHex(key.privateKeyHex()); //web3dart
      final address = await credentials.extractAddress(); //web3dart
      expect(
        address,
        equals(mockAddress),
      );
    });
  });
}
