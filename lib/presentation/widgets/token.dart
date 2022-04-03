import 'package:flutter/material.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/presentation/widgets/icon.dart';

/// Displays a list of SampleItems.
class TokenWidget extends StatelessWidget {
  const TokenWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final TokenItem token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: IconWidget(),
          ),
          Expanded(
            child: Text(token.name),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${token.userFacingBalance} ${token.symbol}',
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
