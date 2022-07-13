// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:my_sarafu/model/authentication_method.dart';
import 'package:my_sarafu/model/device_lock_timeout.dart';
import 'package:my_sarafu/repository/vault_repository.dart';
import 'package:my_sarafu/utils/encrypt.dart';
import 'package:my_sarafu/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Price conversion preference values
enum PriceConversion { none }

/// Singleton wrapper for shared preferences
class SharedPrefsUtil {
  // Keys
  static const String firstLaunchKey = 'fsarafu_first_launch';
  static const String seedBackedUpKey = 'fsarafu_seed_backup';
  static const String appUuidKey = 'fsarafu_app_uuid';
  static const String authMethod = 'fsarafu_auth_method';
  static const String curCurrency = 'fsarafu_currency_pref';
  static const String curLanguage = 'fsarafu_language_pref';
  static const String curTheme = 'fsarafu_theme_pref';
  static const String curExplorer = 'fsarafu_cur_explorer_pref';

  static const String firstcontactAdded = 'fsarafu_first_c_added';
  static const String notificationEnabled = 'fsarafu_notification_on';
  static const String lockSarafu = 'fsarafu_lock_dev';
  static const String sarafuLockTimeout = 'fsarafu_lock_timeout';
  // For maximum pin attempts
  static const String pinAttempts = 'fsarafu_pin_attempts';
  static const String pinLockUntil = 'fsarafu_lock_duraton';
  // For certain keystore incompatible androids
  static const String useLegacyStorage = 'fsarafu_legacy_storage';
  // Caching yellowspyglass API response
  static const String yellowspyglassApiCache =
      'fsarafu_yellowspyglass_api_cache';

  // For plain-text data
  Future<void> set(String key, dynamic value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is double) {
      // When compiled to JS, integer values are represented as floats.
      // That can lead to some unexpected behavior when using either is or is!
      // where the type is either int or double.
      await sharedPreferences.setDouble(key, value);
      // TODO(x): Look in to double_and_int_checks for more info.
      // ignore: avoid_double_and_int_checks
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
  }

  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defaultValue;
  }

  // For encrypted data
  Future<void> setEncrypted(String key, String value) async {
    // Retrieve/Generate encryption password
    var secret = await sl.get<VaultRepository>().getEncryptionPhrase();
    if (secret == null) {
      final encryptionSecret16 = Salsa20Encryptor.generateEncryptionSecret(16);
      final encryptionSecret8 = Salsa20Encryptor.generateEncryptionSecret(16);

      secret = '$encryptionSecret16:$encryptionSecret8';
      await sl.get<VaultRepository>().writeEncryptionPhrase(secret);
    }
    // Encrypt and save
    final ekey = secret.split(':')[0];
    final eiv = secret.split(':')[1];
    final encrypter = Salsa20Encryptor(ekey, eiv);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, encrypter.encrypt(value));
  }

  Future<String?> getEncrypted(String key) async {
    final secret = await sl.get<VaultRepository>().getEncryptionPhrase();
    if (secret == null) return null;
    // Decrypt and return
    final ekey = secret.split(':')[0];
    final eiv = secret.split(':')[1];
    final encrypter = Salsa20Encryptor(ekey, eiv);
    final prefs = await SharedPreferences.getInstance();
    final encrypted = prefs.get(key) as String?;
    if (encrypted == null) return null;
    return encrypter.decrypt(encrypted);
  }

  // Key-specific helpers
  Future<void> setSeedBackedUp(bool value) async {
    return set(seedBackedUpKey, value);
  }

  Future<bool> getSeedBackedUp() async {
    return get(seedBackedUpKey, defaultValue: false) as bool;
  }

  Future<void> setFirstLaunch() async {
    return set(firstLaunchKey, false);
  }

  Future<bool> getFirstLaunch() async {
    return get(firstLaunchKey, defaultValue: true) as bool;
  }

  Future<void> setFirstContactAdded(bool value) async {
    return set(firstcontactAdded, value);
  }

  Future<bool> getFirstContactAdded() async {
    return get(firstcontactAdded, defaultValue: false) as bool;
  }

  Future<void> setUuid(String uuid) async {
    return setEncrypted(appUuidKey, uuid);
  }

  Future<String?> getUuid() async {
    return getEncrypted(appUuidKey);
  }

  Future<void> setAuthMethod(AuthenticationMethod method) async {
    return set(authMethod, method.getIndex());
  }

  Future<AuthenticationMethod> getAuthMethod() async {
    return AuthenticationMethod(
      AuthMethod.values[
          await get(authMethod, defaultValue: AuthMethod.biometrics.index)
              as int],
    );
  }

  // Future<void> setLanguage(LanguageSetting language) async {
  //   return await set(cur_language, language.getIndex());
  // }

  // Future<LanguageSetting> getLanguage() async {
  //   return LanguageSetting(AvailableLanguage.values[await get(cur_language,
  //       defaultValue: AvailableLanguage.DEFAULT.index,)],);
  // }

  Future<void> setNotificationsOn(bool value) async {
    return set(notificationEnabled, value);
  }

  Future<bool> getNotificationsOn() async {
    // Notifications off by default on iOS,
    final bool defaultValue;
    if (Platform.isIOS) {
      defaultValue = false;
    } else {
      defaultValue = true;
    }
    return await get(notificationEnabled, defaultValue: defaultValue) as bool;
  }

  /// If notifications have been set by user/app
  Future<bool> getNotificationsSet() async {
    final value = get(notificationEnabled) as bool?;
    if (value == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> setLock(bool value) async {
    return set(lockSarafu, value);
  }

  Future<bool> getLock() async {
    return get(lockSarafu) as bool;
  }

  Future<void> setLockTimeout(LockTimeoutSetting setting) async {
    return set(sarafuLockTimeout, setting.getIndex());
  }

  Future<LockTimeoutSetting> getLockTimeout() async {
    final value = await get(
      sarafuLockTimeout,
      defaultValue: LockTimeoutOption.one.index,
    ) as int;
    return LockTimeoutSetting(
      LockTimeoutOption.values[value],
    );
  }

  // Locking out when max pin attempts exceeded
  Future<int> getLockAttempts() async {
    return await get(pinAttempts, defaultValue: 0) as int;
  }

  Future<void> incrementLockAttempts() async {
    await set(pinAttempts, await getLockAttempts() + 1);
  }

  Future<void> resetLockAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(pinAttempts);
    await prefs.remove(pinLockUntil);
  }

  Future<bool> shouldLock() async {
    if (await get(pinLockUntil) != null || await getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<bool> usesLegacyStorage() async {
    return await get(useLegacyStorage, defaultValue: false) as bool;
  }

  Future<void> setUseLegacyStorage() async {
    await set(useLegacyStorage, true);
  }

  Future<void> updateLockDate() async {
    final attempts = await getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      await set(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(hours: 24))),
      );
    } else if (attempts >= 15) {
      // 3 failed attempts
      await set(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 15))),
      );
    } else if (attempts >= 10) {
      // 2 failed attempts
      await set(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 5))),
      );
    } else if (attempts >= 5) {
      await set(
        pinLockUntil,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 1))),
      );
    }
  }

  Future<DateTime?> getLockDate() async {
    final lockDateStr = await get(pinLockUntil) as String?;
    if (lockDateStr == null) {
      return null;
    }
    return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
  }

  // For logging out
  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(seedBackedUpKey);
    await prefs.remove(appUuidKey);
    await prefs.remove(curCurrency);
    await prefs.remove(authMethod);
    await prefs.remove(notificationEnabled);
    await prefs.remove(lockSarafu);
    await prefs.remove(pinAttempts);
    await prefs.remove(pinLockUntil);
    await prefs.remove(sarafuLockTimeout);
  }
}
