import 'package:mocktail/mocktail.dart';
import 'package:my_sarafu/model/account.dart';
import 'package:my_sarafu/model/voucher.dart';
import 'package:my_sarafu/repository/vault_repository.dart';
import 'package:my_sarafu/repository/vouchers_repository.dart';
import 'package:web3dart/web3dart.dart';

EthereumAddress mockEthereumAddress =
    EthereumAddress.fromHex('0x0000000000000000000000000000000000000001');
const mockMnemonic =
    // ignore: lines_longer_than_80_chars
    'require rain scan insect goddess weird boring fortune blast round predict sort';
final mockAddress0 =
    EthereumAddress.fromHex('0x44388ec850286ba772beec22088c04a0da59c32a');
final mockAddress1 =
    EthereumAddress.fromHex('0xf83c712c294a1e89acd006b652a8919654bb9c6c');

Voucher mockVoucher = Voucher(
  idx: 0,
  address: mockEthereumAddress,
  symbol: 'SRF',
  name: 'Sarafu',
  balance: BigInt.from(1000000000),
  decimals: 6,
);
Account mockAccount = Account(
  activeVoucher: mockVoucher.address,
  walletAddresses: [mockAddress0, mockAddress1],
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

class MockVaultRepository extends Mock implements VaultRepository {
  @override
  Future<String> setSeed(String mnemonic) async {
    return mnemonic;
  }

  @override
  Future<String> writePin(String pin) async {
    return pin;
  }
}

class MockEthereumAddress extends Mock implements EthereumAddress {}
