import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/utils/format.dart';

void main() {
  group('format', () {
    test('should generate correct countdown format', () async {
      expect(formatCountDown(5), equals('00:05'));
      expect(formatCountDown(11), equals('00:11'));
      expect(formatCountDown(60), equals('01:00'));
      expect(formatCountDown(3600), equals('01:00:00'));
    });
  });
}
