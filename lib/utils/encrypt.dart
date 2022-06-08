import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart' show ParametersWithIV, KeyParameter;
import 'package:pointycastle/stream/salsa20.dart';
import 'package:web3dart/crypto.dart';

///
/// Encryption using Salsa20 from pointycastle
///
class Salsa20Encryptor {
  Salsa20Encryptor(this.key, this.iv)
      : _params = ParametersWithIV<KeyParameter>(
          KeyParameter(Uint8List.fromList(key.codeUnits)),
          Uint8List.fromList(iv.codeUnits),
        );
  final String key;
  final String iv;
  final ParametersWithIV<KeyParameter> _params;
  final Salsa20Engine _cipher = Salsa20Engine();

  String encrypt(String plainText) {
    _cipher
      ..reset()
      ..init(true, _params);

    final input = Uint8List.fromList(plainText.codeUnits);
    final output = _cipher.process(input);

    return bytesToHex(output);
  }

  String decrypt(String cipherText) {
    _cipher
      ..reset()
      ..init(false, _params);

    final input = hexToBytes(cipherText);
    final output = _cipher.process(input);

    return String.fromCharCodes(output);
  }

  static String generateEncryptionSecret(int length) {
    final buffer = StringBuffer();

    const chars =
        r"abcdefghijklmnopqrstuvwxyz0123456789!?&+\-'."; // Characters a passcode may contain
    final rng = Random.secure();
    for (var i = 0; i < length; i++) {
      // ignore: use_string_buffers
      buffer.write(chars[rng.nextInt(chars.length)]);
    }
    return buffer.toString();
  }
}
