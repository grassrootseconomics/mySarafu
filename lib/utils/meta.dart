import 'dart:convert'; // for the utf8.encode method

import 'package:crypto/crypto.dart';

enum Pointer {
  none,
  balances,
  balancesAdjusted,
  custom,
  person,
  phone,
  preferences,
  statement,
  tokenActive,
  tokenData,
  tokenDataList,
  tokenDefault,
  tokenLastReceived,
  tokenLastSent,
  tokenMeta,
  tokenMetaSymbol,
  tokenProof,
  tokenProofSymbol,
  tokenSymbolsList
}

class MetadataPointer {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  MetadataPointer._();
  static const void none = null;
  static const String balances = ':cic.balances';
  static const String balancesAdjusted = 'cic:balances.adjusted';
  static const String custom = ':cic.custom';
  static const String person = ':cic.person';
  static const String phone = ':cic.phone';
  static const String preferences = ':cic.preferences';
  static const String statement = ':cic.statement';
  static const String tokenActive = ':cic.token.active';
  static const String tokenData = ':cic.token.data';
  static const String tokenDataList = ':cic.token.data.list';
  static const String tokenDefault = ':cic.token.default';
  static const String tokenLastReceived = ':cic.token.last.received';
  static const String tokenLastSent = ':cic.token.last.sent';
  static const String tokenMeta = ':cic.token.meta';
  static const String tokenMetaSymbol = ':cic.token.meta.symbol';
  static const String tokenProof = ':cic.token.proof';
  static const String tokenProofSymbol = ':cic.token.proof.symbol';
  static const String tokenSymbolsList = ':cic.token.symbols.list';

  static String? get(Pointer pointer) {
    switch (pointer) {
      case Pointer.balances:
        return balances;
      case Pointer.balancesAdjusted:
        return balancesAdjusted;
      case Pointer.custom:
        return custom;
      case Pointer.person:
        return person;
      case Pointer.phone:
        return phone;
      case Pointer.preferences:
        return preferences;
      case Pointer.statement:
        return statement;
      case Pointer.tokenActive:
        return tokenActive;
      case Pointer.tokenData:
        return tokenData;
      case Pointer.tokenDataList:
        return tokenDataList;
      case Pointer.tokenDefault:
        return tokenDefault;
      case Pointer.tokenLastReceived:
        return tokenLastReceived;
      case Pointer.tokenLastSent:
        return tokenLastSent;
      case Pointer.tokenMeta:
        return tokenMeta;
      case Pointer.tokenMetaSymbol:
        return tokenMetaSymbol;
      case Pointer.tokenProof:
        return tokenProof;
      case Pointer.tokenProofSymbol:
        return tokenProofSymbol;
      case Pointer.tokenSymbolsList:
        return tokenSymbolsList;
      case Pointer.none:
        return null;
    }
  }
}

String generateMetadataPointer(String identifier, Pointer cicType) {
  var identifierBytes = utf8.encode(identifier); // data being hashed
  var type = MetadataPointer.get(cicType);
  print(type);
  var cicTypeBytes = type == null ? utf8.encode('') : utf8.encode(type);
  print(identifierBytes);
  print(cicTypeBytes);
  return sha256.convert(identifierBytes + cicTypeBytes).toString();
  // var digest = sha256.convert(data: bytes);
}

void main() {
  var test = generateMetadataPointer('254723522717', Pointer.phone);
  print(test);
  var test4 = generateMetadataPointer('+254723522717', Pointer.custom);
  print(test4);
  var test2 = generateMetadataPointer('SRF', Pointer.tokenDefault);
  print(test2);
  var test3 = generateMetadataPointer('SRF', Pointer.tokenProofSymbol);
  print(test3);
}

// hash_object = hashlib.new("sha256")
// hash_object.update(identifier)
// hash_object.update(cic_type.value.encode(encoding="utf-8"))
// return hash_object.digest().hex()
