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
  chainSpec: 'evm:kitabu:5050:sarafu ',
  contractRegisteryAddress: '0x6c5dfccd22c1a1188224bbe46a0770a48c23f97f',
  metaUrl: 'https://meta.grassecon.org',
  cacheUrl: 'https://cache.grassecon.org',
  rpcProvider: 'https://rpc.kitabu.grassecon.org',
);

const NetworkPreset testnet = NetworkPreset(
  chainSpec: 'evm:kitabu:5050:sarafu ',
  contractRegisteryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
  metaUrl: 'https://meta.grassecon.net',
  cacheUrl: 'https://cache.grassecon.net',
  rpcProvider: 'https://rpc.grassecon.net',
);
