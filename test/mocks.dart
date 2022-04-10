import 'package:mocktail/mocktail.dart';
import 'package:my_sarafu/logic/data/model/voucher.dart';
import 'package:my_sarafu/logic/data/vouchers_repository.dart';
import 'package:web3dart/web3dart.dart';

var mockEthereumAddress =
    EthereumAddress.fromHex('0x0000000000000000000000000000000000000001');

var mockVoucher = Voucher(
  idx: 0,
  address: mockEthereumAddress,
  symbol: 'SRF',
  name: 'Sarafu',
  balance: BigInt.from(1000000000),
  decimals: 6,
);

class MockVoucherRepository extends Mock implements VoucherRepository {
  @override
  Future<List<Voucher>> getAllVouchers(EthereumAddress address) async {
    final vouchers = <Voucher>[];
    final voucher = vouchers.add(mockVoucher);
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
