part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  final String chainSpec;
  final String registeryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;

  SettingsState({
    required this.chainSpec,
    required this.registeryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
  });
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super(
    chainSpec: 'evm:blockchain:kitabu',
    registeryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
    metaUrl: 'https://meta.grassecon.net',
    cacheUrl: 'https://cache.grassecon.net',
    rpcProvider: 'https://rpc.grassecon.net',
  );
}





