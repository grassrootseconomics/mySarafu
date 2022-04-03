part of 'app_cubit.dart';

// var DefaultSettings = Preferences(
//   chainSpec: 'evm:blockchain:kitabu',
//   registeryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
//   tokenRegistryAddress: '0xEa6225212005E86a4490018Ded4bf37F3E772161',
//   metaUrl: 'https://meta.grassecon.net',
//   cacheUrl: 'https://cache.grassecon.net',
//   rpcProvider: 'https://rpc.grassecon.net',
// );

class AppStateInitial extends Settings {
  AppStateInitial() : super(
    route: '/',
    chainSpec: 'evm:blockchain:kitabu',
    contractRegisteryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
    tokenRegistryAddress: '',
    metaUrl: 'https://meta.grassecon.net',
    cacheUrl: 'https://cache.grassecon.net',
    rpcProvider: 'https://rpc.grassecon.net',
  );
}




