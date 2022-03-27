import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/app/components/icon.dart';
import 'package:my_sarafu/cubit/tokens/tokens_cubit.dart';
import 'package:my_sarafu/data/model/transaction.dart';
import 'package:my_sarafu/utils/Converter.dart';
import 'package:web3dart/credentials.dart';

/// Displays a list of SampleItems.
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
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: IconWidget(),
              ),
              Expanded(
                child:
                    Text('${transaction.sender} -> ${transaction.recipient}'),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${getBalance(state, transaction.sourceToken, transaction.toValue)} ${getSymbol(state, transaction.sourceToken)}',
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

String getSymbol(TokensState tokensState, String address) {
  final token = tokensState.tokens.firstWhereOrNull(
    (token) {
      return token.address == EthereumAddress.fromHex(address);
    },
  );
  return token?.symbol ?? 'Unknown';
}

String getBalance(TokensState tokensState, String address, int balance) {
  final token = tokensState.tokens.firstWhereOrNull(
    (token) => token.address == EthereumAddress.fromHex(address),
  );
  var converter = WeiConverter(token?.decimals ?? 6);
  return converter.getUserFacingValue(BigInt.from(balance));
}
