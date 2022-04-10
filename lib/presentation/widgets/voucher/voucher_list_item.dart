import 'package:flutter/material.dart';
import 'package:my_sarafu/logic/data/model/voucher.dart';
import 'package:my_sarafu/presentation/widgets/icon.dart';
import 'package:my_sarafu/presentation/widgets/voucher/voucher_detailed_view.dart';

class VoucherListItemWidget extends StatelessWidget {
  const VoucherListItemWidget({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.push(
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
