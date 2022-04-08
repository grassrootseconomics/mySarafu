import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dev test', (WidgetTester tester) async {
    var idenifier = utf8.encode('TokenRegistry');
    Uint8List bytes = Uint8List.fromList(idenifier);
    var encoded = hex.encode(bytes);
    const forcePadLength = 32;
  
    final padding = forcePadLength - encoded.length;
    encoded = encoded + ('0' * padding);
    // Verify that our counter starts at 0.
    var test = utf8.encode(encoded);
    expect(test.length, 32);

  });
}
