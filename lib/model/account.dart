// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:web3dart/credentials.dart';

enum AccountType {
  CUSTODIAL_PERSONAL,
  CUSTODIAL_BUSINESS,
  CUSTODIAL_COMMUNITY,
  CUSTODIAL_SYSTEM,
  NON_CUSTODIAL_PERSONAL,
  NON_CUSTODIAL_BUSINESS,
  NON_CUSTODIAL_COMMUNITY,
  NON_CUSTODIAL_SYSTEM,
}

class Account extends Equatable {
  Account({
    required this.name,
    this.activeChainIndex = 0,
    this.accountType = AccountType.NON_CUSTODIAL_PERSONAL,
    required this.walletAddresses,
    required this.activeVoucher,
  });
  EthereumAddress get activeWalletAddress => walletAddresses[activeChainIndex];
  final String name;
  final AccountType accountType;
  final int activeChainIndex;
  final EthereumAddress activeVoucher;
  final List<EthereumAddress> walletAddresses;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'accountType': accountType.name,
      'activeChainIndex': activeChainIndex,
      'walletAddresses': walletAddresses,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['name'] as String,
      accountType: AccountType.values.firstWhere(
        (e) => e.toString() == json['accountType'] as String,
      ),
      activeChainIndex: json['activeChainIndex'] as int,
      walletAddresses: (json['walletAddresses'] as List<String>)
          .map((e) => EthereumAddress.fromHex(e))
          .toList(),
      activeVoucher: EthereumAddress.fromHex(json['activeVoucher'] as String),
    );
  }
  @override
  List<Object?> get props =>
      [name, accountType, activeChainIndex, walletAddresses];

  Account copyWith({
    String? name,
    AccountType? accountType,
    int? activeChainIndex,
    EthereumAddress? activeVoucher,
    List<EthereumAddress>? walletAddresses,
  }) {
    return Account(
        name: name ?? this.name,
        accountType: accountType ?? this.accountType,
        activeChainIndex: activeChainIndex ?? this.activeChainIndex,
        activeVoucher: activeVoucher ?? this.activeVoucher,
        walletAddresses: walletAddresses ?? this.walletAddresses);
  }
}
