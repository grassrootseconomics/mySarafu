enum NetworkPresets {
  mainnet,
  testnet,
  custom,
}

class NetworkPreset {
  NetworkPreset({
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

NetworkPreset mainnet = NetworkPreset(
  chainSpec: 'evm:kitabu:5050:sarafu ',
  contractRegisteryAddress: '0xB3f586562641a0153b516E93Ddf582bA0c476397',
  metaUrl: 'https://meta.grassecon.org',
  cacheUrl: 'https://cache.grassecon.org',
  rpcProvider: 'https://rpc.kitabu.grassecon.org',
);

NetworkPreset testnet = NetworkPreset(
  chainSpec: 'evm:kitabu:5050:sarafu ',
  contractRegisteryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
  metaUrl: 'https://meta.grassecon.net',
  cacheUrl: 'https://cache.grassecon.net',
  rpcProvider: 'https://rpc.grassecon.net',
);
