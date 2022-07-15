// ignore_for_file: lines_longer_than_80_chars

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/cubits/account/cubit.dart';
import 'package:my_sarafu/cubits/vouchers/vouchers_cubit.dart';
import 'package:my_sarafu/model/account.dart';
import 'package:my_sarafu/model/transaction.dart';
import 'package:my_sarafu/utils/converter.dart';
import 'package:my_sarafu/widgets/icon.dart';
import 'package:web3dart/credentials.dart';

enum Direction { incoming, outgoing }

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VouchersCubit, VouchersState>(
      builder: (context, state) {
        final account = context.read<AccountCubit>().state.account;
        final direction = transaction.recipient ==
                account?.walletAddresses[account.activeChainIndex]
            ? Direction.incoming
            : Direction.outgoing;
        final other = direction == Direction.incoming
            ? transaction.sender.hex
            : transaction.recipient.hex;
        final balanceString =
            '${getBalance(state, transaction)} ${getSymbol(state, transaction)}';
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
                  '${truncateAddress(other)}}',
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        balanceString,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Icon(
                      transaction.success ? Icons.check : Icons.close,
                      color: transaction.success ? Colors.green : Colors.red,
                    ),
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

String getSymbol(VouchersState vouchersState, Transaction transaction) {
  final voucher = vouchersState.vouchers.firstWhereOrNull(
    (voucher) {
      return voucher.address ==
          EthereumAddress.fromHex(transaction.destinationVoucher.hex);
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
  final fromConverter = WeiConverter(decimals: fromVoucher?.decimals ?? 6);
  if (fromVoucher?.address == toVoucher?.address) {
    return fromConverter.getUserFacingValue(BigInt.from(tx.toValue));
  } else {
    throw Exception('Unsupported transaction');
  }
}
