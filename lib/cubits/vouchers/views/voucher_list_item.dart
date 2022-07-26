import 'package:flutter/material.dart';
import 'package:mysarafu/cubits/vouchers/views/voucher_detailed_view.dart';
import 'package:mysarafu/model/voucher.dart';
import 'package:mysarafu/widgets/icon.dart';

class VoucherListItemWidget extends StatelessWidget {
  const VoucherListItemWidget({
    Key? key,
    required this.voucher,
    this.onTap,
  }) : super(key: key);

  final Voucher voucher;
  final void Function(Voucher)? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap != null
            ? () => onTap!(voucher)
            : () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        VoucherDetailedView(voucher: voucher),
                  ),
                ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: IconWidget(),
            ),
            Expanded(
              child: Text(voucher.name),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '${voucher.userFacingBalance} ${voucher.symbol}',
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
