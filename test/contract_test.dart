// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
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
