import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

Future<dynamic> fetch(String host, String pointer) async {
  final url = p.join(host, pointer);
  print("$url");
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
  // void get person => fetch(metaUrl, utf8.encode(':cic.person'));

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

  Future<VoucherIssuer> voucherMetaSymbol(String symbol) async {
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

  // {description: Sarafu-Network Services, issuer: Grassroots Economics, namespace: ge, proofs: [bc3330d86a6e64ce819528090e2c329aed0a7d57110bc00eb48ab6d2572e59c3], version: 1}
  Future<VoucherProof> voucherProofSymbol(String symbol) async {
    final dynamic data = await fetch(
      metaUrl,
      hash(identifier: symbol, salt: ':cic.token.proof.symbol'),
    );
    return VoucherProof.fromMap(data);
  }
}

class Contact {
  Contact({this.email, this.phone});
  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Contact.fromMap(dynamic map) {
    return Contact(
      email: map['email'] as String?,
      phone: map['phone'] as String?,
    );
  }
  final String? email;
  final String? phone;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (email != null) {
      result.addAll(<String, String?>{'email': email});
    }
    if (phone != null) {
      result.addAll(<String, String?>{'phone': phone});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}

class VoucherIssuer {
  VoucherIssuer({
    required this.countryCode,
    required this.location,
    required this.name,
    required this.contact,
  });
  factory VoucherIssuer.fromJson(String source) =>
      VoucherIssuer.fromMap(json.decode(source) as Map<String, dynamic>);

  factory VoucherIssuer.fromMap(dynamic map) {
    return VoucherIssuer(
      contact: Contact.fromMap(map['contact']),
      countryCode: map['country_code'] as String? ?? '',
      location: map['location'] as String? ?? '',
      name: map['name'] as String? ?? '',
    );
  }
  final Contact contact;
  final String countryCode;
  final String location;
  final String name;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'contact': contact.toMap(),
      'country_code': countryCode,
      'location': location,
      'name': name
    };

    return result;
  }

  String toJson() => json.encode(toMap());
}

class VoucherProof {
  VoucherProof({
    required this.description,
    required this.issuer,
    required this.namespace,
    required this.proofs,
    required this.version,
  });

  factory VoucherProof.fromMap(dynamic map) {
    return VoucherProof(
      description: map['description'] as String? ?? '',
      issuer: map['issuer'] as String? ?? '',
      namespace: map['namespace'] as String? ?? '',
      proofs: List<String>.from(map['proofs'] as List<dynamic>),
      version: map['version'] as int,
    );
  }

  factory VoucherProof.fromJson(String source) =>
      VoucherProof.fromMap(json.decode(source));
  final String description;
  final String issuer;
  final String namespace;
  final List<String> proofs;
  final int version;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'description': description,
        'issuer': issuer,
        'namespace': namespace,
        'proofs': proofs,
        'version': version,
      };

  String toJson() => json.encode(toMap());
}
