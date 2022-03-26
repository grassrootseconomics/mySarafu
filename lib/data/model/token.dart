import 'package:equatable/equatable.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class TokenItem extends Equatable {
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

  TokenItem copyWith({
    int? idx,
    EthereumAddress? address,
    String? name,
    String? symbol,
    double? balance,
    int? decimals,
  }) {
    return TokenItem(
      idx: idx ?? this.idx,
      address: address ?? this.address,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      balance: balance ?? this.balance,
      decimals: decimals ?? this.decimals,
    );
  }

  @override
  static TokenItem fromJson(dynamic json) {
    log.d("Loading Json for TokenItem ${json}");
    final idx = int.parse(json['idx'] as String);
    final address = json['address'] as String;
    final name = json['name'] as String;
    final symbol = json['symbol'] as String;
    final balance = double.parse(json['balance'] as String);
    final decimals = int.parse(json['decimals'] as String);
    return TokenItem(
      idx: idx,
      address: EthereumAddress.fromHex(address),
      name: name,
      symbol: symbol,
      balance: balance,
      decimals: decimals,
    );
  }

  @override
  Map<String, String> toJson() {
    return {
      'idx': idx.toString(),
      'address': address.toString(),
      'name': name,
      'symbol': symbol,
      'balance': balance.toString(),
      'decimals': decimals.toString(),
    };
  }

  get props => [idx, address, name, symbol, balance, decimals];
}
