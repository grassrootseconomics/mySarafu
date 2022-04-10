import 'package:my_sarafu/logic/contracts/voucher-registery/TokenUniqueSymbolIndex.g.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/data/model/voucher.dart';
import 'package:my_sarafu/logic/data/registry_repository.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';

class VoucherRepository {
  VoucherRepository({
    required this.settings,
    required this.registeryRepo,
    required this.client,
  });

  final SettingsState settings;
  final RegistryRepository registeryRepo;
  final Web3Client client;
  VoucherUniqueSymbolIndex? voucherUniqueSymbolIndexContract;

  List<Voucher> vouchers = [];
  Future<void> getContract() async {
    if (voucherUniqueSymbolIndexContract == null) {
      if (settings.voucherRegistryAddress == null ||
          settings.voucherRegistryAddress!.isEmpty) {
        final voucherRegistryAddress =
            await registeryRepo.getVoucherRegistery();
        voucherUniqueSymbolIndexContract = VoucherUniqueSymbolIndex(
          address: voucherRegistryAddress,
          client: client,
        );
      } else {
        final voucherRegistryAddress =
            EthereumAddress.fromHex(settings.voucherRegistryAddress!);
        log.d(settings.voucherRegistryAddress);

        voucherUniqueSymbolIndexContract = VoucherUniqueSymbolIndex(
          address: voucherRegistryAddress,
          client: client,
        );
      }
    }
  }

  Future<List<Voucher>> getAllVouchers(EthereumAddress address) async {
    await getContract();

    final count = await voucherUniqueSymbolIndexContract!.entryCount();
    final range = List.generate(count.toInt(), (index) => index);
    final vouchers = <Voucher>[];
    await Future.forEach(range, (int idx) async {
      final voucherContractAddress =
          await voucherUniqueSymbolIndexContract!.entry(BigInt.from(idx));
      final erc20 = Erc20(address: voucherContractAddress, client: client);
      final symbol = await erc20.symbol();
      final decimals = await erc20.decimals();
      final balance = await erc20.balanceOf(address);
      final voucher = Voucher(
        idx: idx,
        address: voucherContractAddress,
        symbol: symbol,
        name: symbol,
        balance: balance,
        decimals: decimals.toInt(),
      );
      vouchers.add(voucher);
    });
    return vouchers;
  }

  Future<List<Voucher>> updateBalances(
    EthereumAddress address,
    List<Voucher> vouchers,
  ) async {
    final updated = <Voucher>[];
    await Future.wait(
      vouchers.map((voucher) async {
        final balance = await getBalance(address, voucher);
        log.d('${voucher.symbol} Balance: $balance');
        final updatedVoucher = voucher.copyWith(balance: balance);
        updated.add(updatedVoucher);
      }),
    );
    return updated;
  }

  Future<BigInt> getBalance(EthereumAddress address, Voucher voucher) async {
    final erc20 = Erc20(address: voucher.address, client: client);
    return erc20.balanceOf(address);
  }
}
