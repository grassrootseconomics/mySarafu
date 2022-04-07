import 'dart:convert'; // for the utf8.encode method

import 'package:crypto/crypto.dart';
import 'package:my_sarafu/logic/utils/logger.dart';

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
  final identifierBytes = utf8.encode(identifier); // data being hashed
  final type = MetadataPointer.get(cicType);
  final cicTypeBytes = type == null ? utf8.encode('') : utf8.encode(type);
  logNoStack
    ..d(type)
    ..d(identifierBytes)
    ..d(cicTypeBytes);
  return sha256.convert(identifierBytes + cicTypeBytes).toString();
  // var digest = sha256.convert(data: bytes);
}

void main() {
  final test = generateMetadataPointer('254723522717', Pointer.phone);
  final test4 = generateMetadataPointer('+254723522717', Pointer.custom);
  final test2 = generateMetadataPointer('SRF', Pointer.tokenDefault);
  final test3 = generateMetadataPointer('SRF', Pointer.tokenProofSymbol);
  logNoStack
  ..d(test)
  ..d(test4)
  ..d(test2)
  ..d(test3);
}
