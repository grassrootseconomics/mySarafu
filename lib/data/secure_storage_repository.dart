import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class SecureStorageRepository {
  SecureStorageRepository({required this.accountName});
  String accountName;
  Future<void> unlock() async {}
  Future<void> lock() async {}

  Future<Map<String, String>> _readAll() async {
    final all = await _storage.readAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return all;
  }

  // ignore: unused_element
  Future<void> _addNewItem() async {
    const key = '_randomValue()';
    const value = '_randomValue()';

    await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _readAll();
  }

  // ignore: unused_element
  Future<void> _deleteAll() async {
    await _storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    await _readAll();
  }

  IOSOptions _getIOSOptions() => IOSOptions(
        accountName: accountName,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
