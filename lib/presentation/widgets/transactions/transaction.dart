import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/tokens/tokens_cubit.dart';
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
    return BlocConsumer<TokensCubit, TokensState>(
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
                  '${truncateAddress(transaction.sender.hex)} -> ${truncateAddress(transaction.recipient.hex)}',
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${getBalance(state, transaction)} ${getSymbol(state, transaction.destinationToken.hex)}',
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

String getSymbol(TokensState tokensState, String address) {
  final token = tokensState.tokens.firstWhereOrNull(
    (token) {
      return token.address == EthereumAddress.fromHex(address);
    },
  );
  return token?.symbol ?? 'Unknown';
}

String getBalance(TokensState tokensState, Transaction tx) {
  final fromToken = tokensState.tokens.firstWhereOrNull(
    (token) => token.address == tx.sourceToken,
  );
  final toToken = tokensState.tokens.firstWhereOrNull(
    (token) => token.address == tx.destinationToken,
  );
  final fromConverter = WeiConverter(fromToken?.decimals ?? 6);
  if (fromToken?.address == toToken?.address) {
    return fromConverter.getUserFacingValue(BigInt.from(tx.toValue));
  } else {
    throw Exception('Unsupported transaction');
  }
  // final toConverter = WeiConverter(toToken?.decimals ?? 6);
  // return converter.getUserFacingValue(BigInt.from(balance));
}
