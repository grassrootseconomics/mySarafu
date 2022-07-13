@Skip('Currently failing')
// TODO(x): Rework and Mock Meta Repository
import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/model/network_presets.dart';
import 'package:my_sarafu/model/person.dart';
import 'package:my_sarafu/repository/meta_repository.dart';
import 'package:web3dart/web3dart.dart';

final testAddress =
    EthereumAddress.fromHex('c18989156ffd467aae045d04674e8fbfb477fa44');
final testPersonMap = <String, dynamic>{
  'date_registered': 1603524474,
  'gender': 'male',
  'identities': {
    'evm': {
      'poa': {
        '100:gnosis': ['0A8ac9075131e789a4bF7b54428a7055BaC0a17a']
      },
      'kitabu': {
        '6060:sarafu': ['c18989156ffd467aae045d04674e8fbfb477fa44']
      }
    }
  },
  'location': {'area_name': 'Kilifi town'},
  'products': ['programmer'],
  'vcard':
      // ignore: lines_longer_than_80_chars
      'QkVHSU46VkNBUkQNClZFUlNJT046My4wDQpGTjpXaWxsaWFtXCwgTHVrZQ0KTjpMdWtlO1dpbGxpYW07OzsNClRFTDtUWVA9Q0VMTDorMjU0NzIzNTIyNzE3DQpFTkQ6VkNBUkQNCg=='
};
final testPerson = Person.fromJson(testPersonMap);
void main() {
  group('MetaRepository', () {
    test('getAddressFromPhoneNumber', () async {
      final meta = MetaRepository(metaUrl: mainnet.metaUrl);
      final data = await meta.getAddressFromPhoneNumber('+254723522717');
      expect(data, testAddress);
    });
    test('getMetaFromAddress', () async {
      final meta = MetaRepository(metaUrl: mainnet.metaUrl);
      final data = await meta.getPersonFromAddress(testAddress);
      expect(data, equals(testPerson));
    });
  });
}
