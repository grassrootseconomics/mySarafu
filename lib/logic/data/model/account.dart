import 'package:equatable/equatable.dart';
import 'package:my_sarafu/logic/data/network_presets.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/credentials.dart';

class Account extends Equatable {
  const Account({
    required this.name,
    required this.address,
    required this.encryptedWallet,
    required this.activeVoucher,
  });

  factory Account.fromJson(dynamic json) {
    return Account(
      name: json['name'] as String,
      address: EthereumAddress.fromHex(json['address'] as String),
      encryptedWallet: json['encryptedWallet'] as String,
      activeVoucher: json['activeVoucher'] is String
          ? EthereumAddress.fromHex(json['activeVoucher'] as String)
          : mainnet.defaultVoucherAddress,
    );
  }
  final String name;
  final String encryptedWallet;
  final EthereumAddress address;
  final EthereumAddress activeVoucher;

  bool verifyPassword(String password) {
    try {
      Wallet.fromJson(encryptedWallet, password);
    } catch (e) {
      log.e(e);
      return false;
    }
    return true;
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'address': address.toString(),
      'encryptedWallet': encryptedWallet,
      'activeVoucher': activeVoucher.hexEip55,
    };
  }

  @override
  List<Object?> get props => [name, address, encryptedWallet, activeVoucher];

  Account copyWith({
    String? name,
    String? encryptedWallet,
    EthereumAddress? address,
    EthereumAddress? activeVoucher,
  }) {
    return Account(
      name: name ?? this.name,
      encryptedWallet: encryptedWallet ?? this.encryptedWallet,
      address: address ?? this.address,
      activeVoucher: activeVoucher ?? this.activeVoucher,
    );
  }
}
