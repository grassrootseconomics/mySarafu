import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/tokens/tokens_cubit.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BalanceText(),
        ),
      ),
    );
  }
}

class BalanceText extends StatelessWidget {
  const BalanceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeToken = context.read<TokensCubit>().activeToken;

    return Text(
      '${activeToken?.userFacingBalance} ${activeToken?.symbol}',
      style: theme.textTheme.headlineMedium,
    );
  }
}
