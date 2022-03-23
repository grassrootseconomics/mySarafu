import 'package:flutter/material.dart';
import 'package:my_sarafu/data/model/token.dart';
import 'package:web3dart/web3dart.dart';

import 'icon.dart';

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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: IconWidget(),
          ),
          Expanded(
            child: Text(token.name),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${token.balance.toString()} ${token.symbol}',
                  textAlign: TextAlign.end),
            ),
          ),
        ],
      ),
    );
  }
}
