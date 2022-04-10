import 'dart:convert';
import 'dart:typed_data';

import 'package:my_sarafu/logic/contracts/contract-registery/contract.g.dart';
import 'package:web3dart/web3dart.dart';

class RegistryRepository {
  RegistryRepository({required this.contractRegistery, required this.client})
      : contract = RegisteryContract(
          address: EthereumAddress.fromHex(contractRegistery),
          client: client,
        );
  final String contractRegistery;
  final Web3Client client;
  final RegisteryContract contract;

  Future<EthereumAddress> getVoucherRegistery() async {
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

  Future<EthereumAddress> getDefaultVoucher() async {
    return contract.addressOf(fromText('DefaultVoucher'));
  }
}

Uint8List fromText(String identifier) {
  final bytes = Uint8List.fromList(utf8.encode(identifier));
  final padded = bytes + Uint8List(32 - bytes.length);
  return Uint8List.fromList(padded);
}
