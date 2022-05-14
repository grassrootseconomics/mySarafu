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
      EthereumAddress.fromHex('0xe3e3431bf25b06166513019ed7b21598d27d05dc'),
  metaUrl: 'https://meta.sarafu.network',
  defaultVoucherAddress:
      EthereumAddress.fromHex('aB89822F31c2092861F713F6F34bd6877a8C1878'),
  cacheUrl: 'https://cache.sarafu.network',
  rpcProvider: 'https://rpc.sarafu.network',
);

NetworkPreset testnet = NetworkPreset(
  chainSpec: 'evm:kitabu:5050:sarafu ',
  contractRegistryAddress:
      EthereumAddress.fromHex('0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299'),
  defaultVoucherAddress:
      EthereumAddress.fromHex('aB89822F31c2092861F713F6F34bd6877a8C1878'),
  metaUrl: 'https://meta.grassecon.net',
  cacheUrl: 'https://cache.grassecon.net',
  rpcProvider: 'http://142.93.38.53:8545',
);
