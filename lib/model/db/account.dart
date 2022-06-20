// Represent user-account
import 'package:my_sarafu/model/db/appdb.dart';
import 'package:my_sarafu/model/network_presets.dart';
import 'package:web3dart/credentials.dart';

class Account {
  Account({
    this.id,
    this.index,
    required this.encryptedWallet,
    required this.name,
    this.lastAccess,
    required this.balance,
    required this.address,
    EthereumAddress? activeVoucher,
    this.selected = false,
  }) : activeVoucher = activeVoucher ?? mainnet.defaultVoucherAddress;
  final String encryptedWallet;
  final int? id; // Primary Key
  final int? index; // Index on the seed
  final String name; // Account nickname
  final int? lastAccess; // Last Accessed incrementor
  final bool selected; // Whether this is the currently selected account
  final EthereumAddress address;
  final String balance; // Last known balance in RAW
  final EthereumAddress activeVoucher;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int,
      index: json['index'] as int,
      name: json['name'] as String,
      encryptedWallet: json['encryptedWallet'] as String,
      lastAccess: json['lastAccess'] as int,
      selected: json['selected'] as bool,
      address: EthereumAddress.fromHex(json['address'] as String),
      balance: json['balance'] as String,
      activeVoucher:
          EthereumAddress.fromHex(json['activeVoucherId'] as String));
  bool commit(DBHelper db) {
    db.changeAccount(this);

    return true;
  }

  String getShortName() {
    final splitName = name.split(' ');
    if (splitName.length > 1 &&
        splitName[0].isNotEmpty &&
        splitName[1].isNotEmpty) {
      final firstChar = splitName[0].substring(0, 1);
      var secondPart = splitName[1].substring(0, 1);
      try {
        if (int.parse(splitName[1]) >= 10) {
          secondPart = splitName[1].substring(0, 2);
        }
      } catch (e) {
        // Why is this here??
      }
      return firstChar + secondPart;
    } else if (name.length >= 2) {
      return name.substring(0, 2);
    } else {
      return name.substring(0, 1);
    }
  }
}
