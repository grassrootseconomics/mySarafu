// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/utils/hdwallet.dart';
import 'package:web3dart/credentials.dart';

import '../helpers/mocks.dart';

void main() {
  group('HDWallet', () {
    test('should be able to generate a mnemonic', () async {
      final mnemonic = generateMnemonic();
      expect(mnemonic.length, equals(12));
      expect(validateMnemonic(mnemonic), isTrue);
    });
    test('addresses should match', () async {
      final chain = createChain(mockMnemonic);
      final address0 = await getAddress(chain, 0);
      final address1 = await getAddress(chain, 1);

      expect(address0, equals(mockAddress0));
      expect(address1, equals(mockAddress1));
    });
    test('credendials should match', () async {
      final chain = createChain(mockMnemonic);
      final credentials0 = getCredentials(chain, 0);
      final credentials1 = getCredentials(chain, 1);

      expect(await credentials0.extractAddress(), equals(mockAddress0));
      expect(await credentials1.extractAddress(), equals(mockAddress1));
    });
  });
}
