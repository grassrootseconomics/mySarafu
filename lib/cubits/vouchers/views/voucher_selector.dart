import 'package:flutter/material.dart';
import 'package:mysarafu/model/voucher.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:mysarafu/widgets/inputs/autocomplete.dart';

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
