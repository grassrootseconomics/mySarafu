import 'package:web3dart/credentials.dart';

class Settings {
  final String chainSpec;
  final String registeryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final String tokenRegistryAddress;
  final EthereumAddress? activeToken;
  Settings({
    required this.chainSpec,
    required this.registeryAddress,
    required this.tokenRegistryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
    this.activeToken
  });
}