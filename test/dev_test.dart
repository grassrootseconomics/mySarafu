import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dev test', (WidgetTester tester) async {
    final idenifier = utf8.encode('TokenRegistry');
    final bytes = Uint8List.fromList(idenifier);
    var encoded = hex.encode(bytes);
    const forcePadLength = 32;

    final padding = forcePadLength - encoded.length;
    encoded = encoded + ('0' * padding);
    // Verify that our counter starts at 0.
    final test = utf8.encode(encoded);
    expect(test.length, 32);
  });
}
