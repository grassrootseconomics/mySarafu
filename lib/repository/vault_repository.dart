import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_sarafu/utils/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton for keystore access methods
class VaultRepository {
  static const String seedKey = 'sarafu_seed';
  static const String encryptionKey = 'sarafu_secret_phrase';
  static const String pinKey = 'sarafu_pin';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // Re-usable
  Future<String> _write(String key, String value) async {
    await secureStorage.write(key: key, value: value);

    return value;
  }

  Future<String?> _read(String key, {String? defaultValue}) async {
    return await secureStorage.read(key: key) ?? defaultValue;
  }

  Future<void> deleteAll() async {
    return secureStorage.deleteAll();
  }

  // Specific keys
  Future<String?> getSeed() async {
    return _read(seedKey);
  }

  Future<String> setSeed(String seed) async {
    return _write(seedKey, seed);
  }

  Future<void> deleteSeed() async {
    return secureStorage.delete(key: seedKey);
  }

  Future<String?> getEncryptionPhrase() async {
    return _read(encryptionKey);
  }

  Future<String> writeEncryptionPhrase(String secret) async {
    return _write(encryptionKey, secret);
  }

  Future<void> deleteEncryptionPhrase() async {
    return secureStorage.delete(key: encryptionKey);
  }

  Future<String?> getPin() async {
    return _read(pinKey);
  }

  Future<String> writePin(String pin) async {
    return _write(pinKey, pin);
  }

  Future<void> deletePin() async {
    return secureStorage.delete(key: pinKey);
  }

  // For encrypted data
  Future<void> setEncrypted(String key, String value) async {
    final secret = await getSecret();
    if (secret == null) return;
    // Decrypt and return
    final encrypter = Salsa20Encryptor(
      secret.substring(0, secret.length - 8),
      secret.substring(secret.length - 8),
    );
    // Encrypt and save
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, encrypter.encrypt(value));
  }

  static const _channel = MethodChannel('fappchannel');

  Future<String?> getSecret() async {
    // TODO(x): This is not implemented;
    return _channel.invokeMethod('getSecret');
  }
}
