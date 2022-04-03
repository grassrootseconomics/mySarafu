import 'package:equatable/equatable.dart';
import 'package:my_sarafu/logic/utils/Converter.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class TokenItem extends Equatable {
  const TokenItem({
    required this.idx,
    required this.address,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.decimals,
  });

  factory TokenItem.fromJson(dynamic json) {
    log.d("Loading Json for TokenItem ${json}");
    final idx = int.parse(json['idx'] as String);
    final address = json['address'] as String;
    final name = json['name'] as String;
    final symbol = json['symbol'] as String;
    final balance = BigInt.tryParse(json['balance'] as String);
    final decimals = int.parse(json['decimals'] as String);
    return TokenItem(
      idx: idx,
      address: EthereumAddress.fromHex(address),
      name: name,
      symbol: symbol,
      balance: balance ?? BigInt.zero,
      decimals: decimals,
    );
  }
  final int idx;
  final EthereumAddress address;
  final String name;
  final String symbol;
  final BigInt balance;
  final int decimals;

  String get userFacingBalance {
    final converter = WeiConverter(decimals);
    return converter.getUserFacingValue(balance);
  }

  TokenItem copyWith({
    int? idx,
    EthereumAddress? address,
    String? name,
    String? symbol,
    BigInt? balance,
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

class TokenList {
  const TokenList({
    required this.tokens,
  });

  factory TokenList.fromJson(dynamic json) {
    try {
      final tokensList = TokenList(
        tokens: List<Map<String, dynamic>>.from(json['tokens'] as List)
            .map<TokenItem>(TokenItem.fromJson)
            .toList(),
      );
      tokensList.tokens.sort((a, b) => b.balance.compareTo(a.balance));
      return tokensList;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
  final List<TokenItem> tokens;

  Map<String, Object> toJson() => <String, Object>{
        'tokens': tokens.map((e) => e.toJson()).toList(),
      };
}
