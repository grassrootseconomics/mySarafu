import 'package:web3dart/credentials.dart';

class Account {
  Account({
    required this.name,
    required this.address,
    required this.encryptedWallet,
  });

  factory Account.fromJson(dynamic json) {
    return Account(
      name: json['name'] as String,
      address: EthereumAddress.fromHex(json['address'] as String),
      encryptedWallet: json['encryptedWallet'] as String,
    );
  }
  final String name;
  final String encryptedWallet;
  final EthereumAddress address;

  Map<String, String> toJson() {
    return {
      'name': name,
      'address': address.toString(),
      'encryptedWallet': encryptedWallet,
    };
  }
}
