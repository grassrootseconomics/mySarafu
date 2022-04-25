import 'package:flutter/material.dart';

class SendWidget extends StatelessWidget {
  const SendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Send',
            textAlign: TextAlign.center,
          ),
        ),
        const Text(
          'Sarafu (SRF)',
        ),
        const Text(
          '100,000 SRF Available',
          textAlign: TextAlign.right,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code),
              onPressed: () {},
              label: const Text(
                'Scan',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text(
                'Send',
              ),
            ),
          ],
        )
      ],
    );
  }
}
