import 'package:my_sarafu/logic/data/model/token.dart';

class Settings {
  Settings({
    required this.chainSpec,
    required this.route,
    required this.contractRegisteryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
    this.tokenRegistryAddress,
    this.activeToken,
    this.encryptedWallet,
    this.walletAddress,
    this.walletPassword,
    this.tokens = const TokenList(tokens: []),
  });
  final String route;
  final String chainSpec;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final String contractRegisteryAddress;
  final String? tokenRegistryAddress;
  final TokenItem? activeToken;
  final String? encryptedWallet;
  final String? walletAddress;
  final String? walletPassword;
  final TokenList tokens;
}
