import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/vouchers/vouchers_cubit.dart';
import 'package:my_sarafu/logic/data/model/account.dart';
import 'package:my_sarafu/logic/data/model/transaction.dart';
import 'package:my_sarafu/logic/utils/Converter.dart';
import 'package:my_sarafu/presentation/widgets/icon.dart';
import 'package:web3dart/credentials.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VouchersCubit, VouchersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final account = context
            .select<AccountsCubit, Account?>((cubit) => cubit.activeAccount);
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: IconWidget(),
              ),
              Expanded(
                child: Text(
                  'B${transaction.blockNumber} ${truncateAddress(transaction.sender.hex)} -> ${truncateAddress(transaction.recipient.hex)}',
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${getBalance(state, transaction)} ${getSymbol(state, transaction.destinationVoucher.hex)}',
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Icon(transaction.success ? Icons.check : Icons.close,
                        color: transaction.success ? Colors.green : Colors.red),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String truncateAddress(String address) =>
    address.replaceRange(4, address.length - 4, '...');

String getSymbol(VouchersState vouchersState, String address) {
  final voucher = vouchersState.vouchers.firstWhereOrNull(
    (voucher) {
      return voucher.address == EthereumAddress.fromHex(address);
    },
  );
  return voucher?.symbol ?? 'Unknown';
}

String getBalance(VouchersState vouchersState, Transaction tx) {
  final fromVoucher = vouchersState.vouchers.firstWhereOrNull(
    (voucher) => voucher.address == tx.sourceVoucher,
  );
  final toVoucher = vouchersState.vouchers.firstWhereOrNull(
    (voucher) => voucher.address == tx.destinationVoucher,
  );
  final fromConverter = WeiConverter(fromVoucher?.decimals ?? 6);
  if (fromVoucher?.address == toVoucher?.address) {
    return fromConverter.getUserFacingValue(BigInt.from(tx.toValue));
  } else {
    throw Exception('Unsupported transaction');
  }
  // final toConverter = WeiConverter(toVoucher?.decimals ?? 6);
  // return converter.getUserFacingValue(BigInt.from(balance));
}
