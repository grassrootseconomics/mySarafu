import 'package:equatable/equatable.dart';
import 'package:my_sarafu/logic/utils/converter.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class Voucher extends Equatable {
  const Voucher({
    required this.idx,
    required this.address,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.decimals,
  });

  factory Voucher.fromJson(dynamic json) {
    log.d("Loading Json for VoucherItem $json");
    final idx = int.parse(json['idx'] as String);
    final address = json['address'] as String;
    final name = json['name'] as String;
    final symbol = json['symbol'] as String;
    final balance = BigInt.tryParse(json['balance'] as String);
    final decimals = int.parse(json['decimals'] as String);
    return Voucher(
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
    final converter = WeiConverter(decimals: decimals);
    return converter.getUserFacingValue(balance);
  }

  Voucher copyWith({
    int? idx,
    EthereumAddress? address,
    String? name,
    String? symbol,
    BigInt? balance,
    int? decimals,
  }) {
    return Voucher(
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

  @override
  List<Object?> get props => [idx, address, name, symbol, balance, decimals];
}

class VoucherList {
  const VoucherList({
    required this.vouchers,
  });

  factory VoucherList.fromJson(dynamic json) {
    try {
      final vouchersList = VoucherList(
        vouchers: List<Map<String, dynamic>>.from(json['vouchers'] as List)
            .map<Voucher>(Voucher.fromJson)
            .toList(),
      );
      vouchersList.vouchers.sort((a, b) => b.balance.compareTo(a.balance));
      return vouchersList;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
  final List<Voucher> vouchers;

  Map<String, Object> toJson() => <String, Object>{
        'vouchers': vouchers.map((e) => e.toJson()).toList(),
      };
}
