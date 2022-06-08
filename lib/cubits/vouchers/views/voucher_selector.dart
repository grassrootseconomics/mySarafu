import 'package:flutter/material.dart';
import 'package:my_sarafu/data/model/voucher.dart';
import 'package:my_sarafu/utils/logger.dart';
import 'package:my_sarafu/widgets/inputs/autocomplete.dart';

class VoucherSelector extends StatelessWidget {
  const VoucherSelector({Key? key, required this.vouchers}) : super(key: key);

  final List<Voucher> vouchers;
  @override
  Widget build(BuildContext context) {
    return AutocompleteWidget<Voucher>(
      displayStringForOption: (p0) => '${p0.name} - ${p0.balance}',
      options: vouchers,
      onSelected: (voucher) => {log.d(voucher)},
      search: (searchString, vouchers) =>
          vouchers.where((voucher) => voucher.name.contains(searchString)),
    );
  }
}
