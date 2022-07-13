import 'package:mocktail/mocktail.dart';
import 'package:my_sarafu/model/account.dart';
import 'package:my_sarafu/model/voucher.dart';
import 'package:my_sarafu/repository/vouchers_repository.dart';
import 'package:web3dart/web3dart.dart';

EthereumAddress mockEthereumAddress =
    EthereumAddress.fromHex('0x0000000000000000000000000000000000000001');

Voucher mockVoucher = Voucher(
  idx: 0,
  address: mockEthereumAddress,
  symbol: 'SRF',
  name: 'Sarafu',
  balance: BigInt.from(1000000000),
  decimals: 6,
);
Account mockAccount = Account(
  name: 'test',
  address:
      EthereumAddress.fromHex('0xe9a189e312a46d4ee1ef1f818c231a50c87f8461'),
  encryptedWallet:
      // ignore: lines_longer_than_80_chars
      '{"crypto":{"cipher":"aes-128-ctr","cipherparams":{"iv":"613fc70ec83e552b9c4bc6316ebc5f1a"},"ciphertext":"a3302d2f7cf8f34ef2edd2892c21c65d57bbe2824eafccaa98b91a038eb4cba182","kdf":"scrypt","kdfparams":{"dklen":32,"n":8192,"r":8,"p":1,"salt":"6fdd7b6f5af612bdb4443a90bbe95606cec5497a147941f8c11628f5b8111807"},"mac":"0c8b92cf3c111557f599a76e1c01525ae0eb8bac9ef2f5189bac8893ae338a10"},"id":"830ed4f9-6857-46a2-8c3e-1ee45f2176b7","version":3}',
  activeVoucher:
      EthereumAddress.fromHex('0xab89822f31c2092861f713f6f34bd6877a8c1878'),
);
Account mockAccount2 = Account(
  name: 'test2',
  address:
      EthereumAddress.fromHex('0x7b0a61fe658f7a3be9b564ba0df95dc5a1681b1d'),
  encryptedWallet:
      // ignore: lines_longer_than_80_chars
      '{"crypto":{"cipher":"aes-128-ctr","cipherparams":{"iv":"79a5ea90b882b97481fd50b61650c5d5"},"ciphertext":"15bda7f7d6a58bda25081fed0ebfbb27db9d4951366325a4d6c80510d6d68962ac","kdf":"scrypt","kdfparams":{"dklen":32,"n":8192,"r":8,"p":1,"salt":"57d3683fc209d163c5cbc4ea6f13ab7cdfe345f93d6a6c5675563ba4c67af42f"},"mac":"1007ad1bd92a013ada5ae26de05790e96b41f078a39cf6e008bf7ca3afabea3d"},"id":"c55907e9-bc29-425a-b678-c37d31bfcab2","version":3}',
  activeVoucher:
      EthereumAddress.fromHex('0xab89822f31c2092861f713f6f34bd6877a8c1878'),
);

class MockVoucherRepository extends Mock implements VoucherRepository {
  @override
  Future<List<Voucher>> getAllVouchers(EthereumAddress address) async {
    final vouchers = <Voucher>[mockVoucher];
    return vouchers;
  }

  @override
  Future<List<Voucher>> updateBalances(
    EthereumAddress address,
    List<Voucher> vouchers,
  ) async {
    final updated = <Voucher>[];
    for (final voucher in vouchers) {
      final updatedVoucher = Voucher(
        idx: voucher.idx,
        address: voucher.address,
        symbol: voucher.symbol,
        name: voucher.name,
        balance: voucher.balance * BigInt.from(2),
        decimals: 6,
      );
      updated.add(updatedVoucher);
    }
    return updated;
  }
}

class MockEthereumAddress extends Mock implements EthereumAddress {}
