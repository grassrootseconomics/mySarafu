import 'package:web3dart/web3dart.dart';

enum NetworkPresets {
  mainnet,
  testnet,
  custom,
}

class NetworkPreset {
  const NetworkPreset({
    required this.chainSpec,
    required this.rpcProvider,
    required this.metaUrl,
    required this.cacheUrl,
    required this.contractRegistryAddress,
    required this.defaultVoucherAddress,
  });
  final String chainSpec;
  final String rpcProvider;
  final String metaUrl;
  final String cacheUrl;
  final EthereumAddress contractRegistryAddress;
  final EthereumAddress defaultVoucherAddress;
}

NetworkPreset mainnet = NetworkPreset(
  chainSpec: 'evm:kitabu:6060:sarafu',
  contractRegistryAddress:
      EthereumAddress.fromHex('0x5A7e6aEBDA04Aee38aEd1Fc3C87dA589eeB92FeC'),
  metaUrl: 'https://meta.sarafu.network',
  defaultVoucherAddress:
      EthereumAddress.fromHex('02b0DF387A3A68AA3134668752dd82bE70B7dE1C'),
  cacheUrl: 'https://cache.sarafu.network',
  rpcProvider: 'https://rpc.sarafu.network',
);

NetworkPreset testnet = NetworkPreset(
  chainSpec: 'evm:kitabu:6060:sarafu',
  contractRegistryAddress:
      EthereumAddress.fromHex('0x47269C43e4aCcA5CFd09CB4778553B2F69963303'),
  defaultVoucherAddress:
      EthereumAddress.fromHex('1d5bf1c253154BDB4aECC3130b3661AAc01d53a4'),
  metaUrl: 'https://meta.sarafu.network',
  cacheUrl: 'https://cache.sarafu.network',
  rpcProvider: 'https://rpc.sarafu.network',
);
