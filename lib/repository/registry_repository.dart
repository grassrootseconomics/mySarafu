import 'dart:convert';
import 'dart:typed_data';

import 'package:mysarafu/contracts/contract-registry/contractRegistry.g.dart';
import 'package:web3dart/web3dart.dart';

class RegistryRepository {
  RegistryRepository({required this.contractRegistry, required this.client})
      : contract = ContractRegistry(
          address: contractRegistry,
          client: client,
        );
  final EthereumAddress contractRegistry;
  final Web3Client client;
  final ContractRegistry contract;

  Future<EthereumAddress> getVoucherRegistry() async {
    return contract.addressOf(fromText('TokenRegistry'));
  }

  Future<EthereumAddress> getAccountRegistry() async {
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

  Future<EthereumAddress> getContractRegistry() async {
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
