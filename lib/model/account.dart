// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:my_sarafu/model/network_presets.dart';
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
  const Account({
    this.activeChainIndex = 0,
    this.accountType = AccountType.NON_CUSTODIAL_PERSONAL,
    required this.walletAddresses,
    required this.activeVoucher,
    this.verified = false,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountType: AccountType.values.byName(json['accountType'] as String),
      activeChainIndex: json['activeChainIndex'] as int,
      walletAddresses: (json['walletAddresses'] as List<String>)
          .map(EthereumAddress.fromHex)
          .toList(),
      activeVoucher: json['activeVoucher'] is String
          ? EthereumAddress.fromHex(json['activeVoucher'] as String)
          : mainnet.defaultVoucherAddress,
      verified: json['verified'] as bool,
    );
  }
  EthereumAddress get activeWalletAddress => walletAddresses[activeChainIndex];
  final AccountType accountType;
  final int activeChainIndex;
  final EthereumAddress activeVoucher;
  final List<EthereumAddress> walletAddresses;
  final bool verified;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accountType': accountType.name,
      'activeChainIndex': activeChainIndex,
      'walletAddresses': walletAddresses.map((e) => e.hexEip55).toList(),
      'activeVoucher': activeVoucher.hexEip55,
      'verified': verified,
    };
  }

  @override
  List<Object?> get props => [accountType, activeChainIndex, walletAddresses];

  Account copyWith({
    AccountType? accountType,
    int? activeChainIndex,
    EthereumAddress? activeVoucher,
    List<EthereumAddress>? walletAddresses,
  }) {
    return Account(
      accountType: accountType ?? this.accountType,
      activeChainIndex: activeChainIndex ?? this.activeChainIndex,
      activeVoucher: activeVoucher ?? this.activeVoucher,
      walletAddresses: walletAddresses ?? this.walletAddresses,
    );
  }
}
