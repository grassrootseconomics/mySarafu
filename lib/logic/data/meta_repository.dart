import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:my_sarafu/logic/data/model/person.dart';
import 'package:my_sarafu/logic/data/model/voucher.dart';
import 'package:path/path.dart' as p;
import 'package:web3dart/credentials.dart';

Future<dynamic> fetch(String host, String pointer) async {
  final url = p.join(host, pointer);
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final dynamic json = jsonDecode(response.body);
    return json;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
      'Request to $url failed with status: ${response.statusCode}.\n Reason: ${response.reasonPhrase}',
    );
  }
}

String hash({String? identifier, required String salt}) {
  if (identifier == null) {
    return sha256.convert(utf8.encode(salt)).toString();
  }
  return sha256.convert(utf8.encode(identifier) + utf8.encode(salt)).toString();
}

class MetaRepository {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  MetaRepository({required this.metaUrl});
  final String metaUrl;
  Null get none => null;
  void voucherDefault() => fetch(
        metaUrl,
        sha256.convert(utf8.encode(':cic.token.default')).toString(),
      );
  void get balances =>
      fetch(metaUrl, sha256.convert(utf8.encode(':cic.balances')).toString());
  // void get balancesAdjusted =>
  //     fetch(metaUrl, utf8.encode('cic:balances.adjusted'));
  Future<dynamic> custom(String address) async {
    return fetch(metaUrl, hash(identifier: address, salt: ':cic.custom'));
  }

  Future<EthereumAddress> getAddressFromPhoneNumber(String phoneNumber) async {
    final dynamic data =
        await fetch(metaUrl, hash(identifier: phoneNumber, salt: ':cic.phone'));
    return EthereumAddress.fromHex(data.toString());
  }

  Future<Person> getPersonFromAddress(EthereumAddress address) async {
    final h = sha256
        .convert(address.addressBytes + utf8.encode(':cic.person'))
        .toString();
    final data = await fetch(metaUrl, h) as Map<String, dynamic>;
    return Person.fromJson(data);
  }
  // void phone(String phoneNumber) => fetch(metaUrl, utf8.encode(':cic.phone'));
  // void preferences() => fetch(metaUrl, utf8.encode(':cic.preferences'));

  // void statement() => fetch(metaUrl, utf8.encode(':cic.statement'));
  // void voucherActive() => fetch(metaUrl, utf8.encode(':cic.token.active'));
  // void voucherDataList() => fetch(metaUrl, utf8.encode(':cic.voucher.data.list'));
  // void voucherData() => fetch(metaUrl, utf8.encode(':cic.token.data'));
  // void voucherLastReceived() =>
  //     fetch(metaUrl, utf8.encode(':cic.token.last.received'));
  // void voucherLastSent() => fetch(metaUrl, utf8.encode(':cic.voucher.last.sent'));
  // void voucherMeta() => fetch(metaUrl, utf8.encode(':cic.token.meta'));

  // {
  //  contact: {
  //    email: info@grassecon.org,
  //    phone: +254757628885
  //  },
  //  country_code: KE,
  //  location: Kilifi,
  //  name: Grassroots Economics
  // }

  Future<VoucherIssuer> getVoucherMetaFromSymbol(String symbol) async {
    final dynamic data = await fetch(
      metaUrl,
      hash(identifier: symbol, salt: ':cic.token.meta.symbol'),
    );
    return VoucherIssuer.fromMap(data);
  }

  // Future<VoucherProof> voucherProof() async {
  //   dynamic data =
  //       await fetch(metaUrl, hash(identifier: "", salt: ':cic.voucher.proof'));
  //   return VoucherProof.fromMap(data);
  // }

  Future<VoucherProof> getVoucherProofFromSymbol(String symbol) async {
    final dynamic data = await fetch(
      metaUrl,
      hash(identifier: symbol, salt: ':cic.token.proof.symbol'),
    );
    return VoucherProof.fromMap(data);
  }
}
