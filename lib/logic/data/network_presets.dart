enum NetworkPresets {
  mainnet,
  testnet,
  custom,
}

class NetworkPreset {
  const NetworkPreset({
    required this.chainSpec,
    required this.contractRegisteryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
  });
  final String chainSpec;
  final String contractRegisteryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
}

const NetworkPreset mainnet = NetworkPreset(
  chainSpec: 'evm:kitabu:6060:sarafu ',
  contractRegisteryAddress: '0xe3e3431bf25b06166513019ed7b21598d27d05dc',
  metaUrl: 'https://meta.sarafu.network',
  cacheUrl: 'https://cache.sarafu.network',
  rpcProvider: 'http://142.93.38.53:8545',
);

const NetworkPreset testnet = NetworkPreset(
  chainSpec: 'evm:kitabu:5050:sarafu ',
  contractRegisteryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
  metaUrl: 'https://meta.grassecon.net',
  cacheUrl: 'https://cache.grassecon.net',
  rpcProvider: 'https://rpc.grassecon.net',
);