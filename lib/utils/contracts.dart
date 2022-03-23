import 'dart:convert';
import 'dart:math'; //used for the random number generator
import 'dart:typed_data';

import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/contracts/token-registery/TokenUniqueSymbolIndex.g.dart';
import 'package:my_sarafu/utils/Converter.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart'; //You can also import the browser version

import '../contracts/contract-registery/contract.g.dart';

// In either way, the library can derive the public key and the address
// from a private key:
Wallet createWallet() {
  final rng = Random.secure();
  final credentials = EthPrivateKey.createRandom(rng);
  final wallet = Wallet.createNew(credentials, 'password', rng);
  return wallet;
}

Wallet loadWallet(String walletJson, String password) {
  final wallet = Wallet.fromJson(walletJson, password);
  return wallet;
}

Future<EtherAmount> connectRPC(Wallet wallet, String rpcProvider) async {
  final httpClient = Client();
  final ethClient = Web3Client(rpcProvider, httpClient);
  final chainID = await ethClient.getChainId();
  final networkId = await ethClient.getNetworkId();
  final contract = RegisteryContract(
      address:
          EthereumAddress.fromHex("0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299"),
      client: ethClient);
  final tokenregistry = await contract.addressOf(fromText('TokenRegistry'));
  final accountregistry = await contract.addressOf(fromText('AccountRegistry'));
  final faucet = await contract.addressOf(fromText('Faucet'));
  final addressdeclarator =
      await contract.addressOf(fromText('AddressDeclarator'));
  final transferauthorization =
      await contract.addressOf(fromText('TransferAuthorization'));
  final contractregistry =
      await contract.addressOf(fromText('ContractRegistry'));
  final defaulttoken = await contract.addressOf(fromText('DefaultToken'));
  print("TokenRegistery: ${tokenregistry}");
  print("AccountRegistry: ${accountregistry}");
  print("Faucet: ${faucet}");
  print("AddressDeclarator: ${addressdeclarator}");
  print("TransferAuthorization: ${transferauthorization}");
  print("ContractRegistry: ${contractregistry}");
  print("DefaultToken: ${defaulttoken}");
  // You can now call rpc methods. This one will query the amount of Ether you own
  final balance = await ethClient.getBalance(wallet.privateKey.address);
  print(balance.getValueInUnit(EtherUnit.ether));

  final tokenUniqueSymbolIndexContract =
      TokenUniqueSymbolIndex(address: tokenregistry, client: ethClient);
  final count = await tokenUniqueSymbolIndexContract.entryCount();
  print("TokenUniqueSymbolIndex: ${count}");

  final range = List.generate(count.toInt(), (index) => index);
  print("My Address: ${wallet.privateKey.address}");
  await Future.forEach(range, (int element) async {
    final address =
        await tokenUniqueSymbolIndexContract.entry(new BigInt.from(element));
    final erc20 = Erc20(address: address, client: ethClient);
    final symbol = await erc20.symbol();
    final balance = await erc20.balanceOf(wallet.privateKey.address);
    var converter = WeiConverter(6);
    print(
        "${symbol}: ${address}: Balance: ${converter.getValueInUnit(balance)}");
  });
  return balance;
}

Uint8List fromText(String identifier) {
  final bytes = Uint8List.fromList(utf8.encode(identifier));
  final padded = bytes + Uint8List(32 - bytes.length);
  return Uint8List.fromList(padded);
}
