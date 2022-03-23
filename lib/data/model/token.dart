import 'package:web3dart/web3dart.dart';

class TokenItem {
  final int idx;
  final EthereumAddress address;
  final String name;
  final String symbol;
  final double balance;
  final int decimals;
  
  const TokenItem({
    required this.idx,
    required this.address,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.decimals,
  });
}
