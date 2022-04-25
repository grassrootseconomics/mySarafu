import 'dart:convert';
import 'dart:math'; //used for the random number generator
import 'dart:typed_data';

import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/logic/contracts/contract-registery/contract.g.dart';
import 'package:my_sarafu/logic/contracts/voucher-registery/TokenUniqueSymbolIndex.g.dart';
import 'package:my_sarafu/logic/utils/converter.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';

// In either way, the library can derive the public key and the address
// from a private key:
String createAccount(String password) {
  final rng = Random.secure();
  final credentials = EthPrivateKey.createRandom(rng);
  final wallet = Wallet.createNew(credentials, 'password', rng);
  // final address = wallet.privateKey.address;
  return wallet.toJson();
}

Wallet decryptWallet(String walletJson, String password) {
  final wallet = Wallet.fromJson(walletJson, password);
  return wallet;
}

Future<EtherAmount> connectRPC(Wallet wallet, String rpcProvider) async {
  final httpClient = Client();
  final ethClient = Web3Client(rpcProvider, httpClient);
  final contract = RegisteryContract(
      address:
          EthereumAddress.fromHex('0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299'),
      client: ethClient);
  final voucherregistry = await contract.addressOf(fromText('VoucherRegistry'));
  final accountregistry = await contract.addressOf(fromText('AccountRegistry'));
  final faucet = await contract.addressOf(fromText('Faucet'));
  final addressdeclarator =
      await contract.addressOf(fromText('AddressDeclarator'));
  final transferauthorization =
      await contract.addressOf(fromText('TransferAuthorization'));
  final contractregistry =
      await contract.addressOf(fromText('ContractRegistry'));
  final defaultvoucher = await contract.addressOf(fromText('DefaultVoucher'));
  log
    ..d('VoucherRegistery: $voucherregistry')
    ..d('AccountRegistry: $accountregistry')
    ..d('Faucet: $faucet')
    ..d('AddressDeclarator: $addressdeclarator')
    ..d('TransferAuthorization: $transferauthorization')
    ..d('ContractRegistry: $contractregistry')
    ..d('DefaultVoucher: $defaultvoucher');
  // You can now call rpc methods. This one will query the amount of Ether you own
  final balance = await ethClient.getBalance(wallet.privateKey.address);
  log.d(balance.getValueInUnit(EtherUnit.ether));

  final voucherUniqueSymbolIndexContract =
      VoucherUniqueSymbolIndex(address: voucherregistry, client: ethClient);
  final count = await voucherUniqueSymbolIndexContract.entryCount();
  log.d('VoucherUniqueSymbolIndex: $count');

  final range = List.generate(count.toInt(), (index) => index);
  log.d('My Address: ${wallet.privateKey.address}');
  await Future.forEach(range, (int element) async {
    final address =
        await voucherUniqueSymbolIndexContract.entry(new BigInt.from(element));
    final erc20 = Erc20(address: address, client: ethClient);
    final symbol = await erc20.symbol();
    final balance = await erc20.balanceOf(wallet.privateKey.address);
    const converter = WeiConverter(decimals: 6);
    log.d(
        '$symbol: $address: Balance: ${converter.getUserFacingValue(balance)}');
  });
  return balance;
}

Uint8List fromText(String identifier) {
  final bytes = Uint8List.fromList(utf8.encode(identifier));
  final padded = bytes + Uint8List(32 - bytes.length);
  return Uint8List.fromList(padded);
}
