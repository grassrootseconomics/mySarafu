import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/data/model/account.dart';
import 'package:my_sarafu/presentation/widgets/icon.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    Key? key,
    required this.account,
    required this.accountIdx,
    required this.onPressed,
  }) : super(key: key);
  final Function(int accountIdx) onPressed;
  final int accountIdx;
  final Account account;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: const IconWidget(),
      title: Text(account.name),
      onTap: () => onPressed(accountIdx),
      subtitle: Text('${account.address}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: () => context.read<AccountsCubit>().deleteAccount(
              accountIdx,
              password: 'test',
            ),
      ),
    );
  }
}
