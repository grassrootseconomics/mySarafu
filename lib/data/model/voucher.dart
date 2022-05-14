import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:my_sarafu/data/model/contact.dart';
import 'package:my_sarafu/utils/converter.dart';
import 'package:my_sarafu/utils/logger.dart';
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

  factory Voucher.fromJson(Map<String, dynamic> json) {
    log.d('Loading Json for VoucherItem $json');
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

  factory VoucherList.fromJson(Map<String, dynamic> json) {
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

class VoucherIssuer {
  VoucherIssuer({
    required this.countryCode,
    required this.location,
    required this.name,
    required this.contact,
  });
  factory VoucherIssuer.fromJson(String source) =>
      VoucherIssuer.fromMap(json.decode(source) as Map<String, dynamic>);

  factory VoucherIssuer.fromMap(Map<String, dynamic> map) {
    return VoucherIssuer(
      contact: Contact.fromMap(map['contact'] as Map<String, dynamic>),
      countryCode: map['country_code'] as String? ?? '',
      location: map['location'] as String? ?? '',
      name: map['name'] as String? ?? '',
    );
  }
  final Contact contact;
  final String countryCode;
  final String location;
  final String name;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'contact': contact.toMap(),
      'country_code': countryCode,
      'location': location,
      'name': name
    };

    return result;
  }

  String toJson() => json.encode(toMap());
}

class VoucherProof {
  VoucherProof({
    required this.description,
    required this.issuer,
    required this.namespace,
    required this.proofs,
    required this.version,
  });

  factory VoucherProof.fromMap(Map<String, dynamic> map) {
    return VoucherProof(
      description: map['description'] as String? ?? '',
      issuer: map['issuer'] as String? ?? '',
      namespace: map['namespace'] as String? ?? '',
      proofs: List<String>.from(map['proofs'] as List<dynamic>),
      version: map['version'] as int,
    );
  }

  factory VoucherProof.fromJson(String source) =>
      VoucherProof.fromMap(json.decode(source) as Map<String, dynamic>);
  final String description;
  final String issuer;
  final String namespace;
  final List<String> proofs;
  final int version;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'description': description,
        'issuer': issuer,
        'namespace': namespace,
        'proofs': proofs,
        'version': version,
      };

  String toJson() => json.encode(toMap());
}
