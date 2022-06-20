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
  static const String first_launch_key = 'fsarafu_first_launch';
  static const String seed_backed_up_key = 'fsarafu_seed_backup';
  static const String app_uuid_key = 'fsarafu_app_uuid';
  static const String price_conversion = 'fsarafu_price_conversion_pref';
  static const String auth_method = 'fsarafu_auth_method';
  static const String cur_currency = 'fsarafu_currency_pref';
  static const String cur_language = 'fsarafu_language_pref';
  static const String cur_theme = 'fsarafu_theme_pref';
  static const String cur_explorer = 'fsarafu_cur_explorer_pref';
  static const String user_representative =
      'fsarafu_user_rep'; // For when non-opened accounts have set a representative
  static const String firstcontact_added = 'fsarafu_first_c_added';
  static const String notification_enabled = 'fsarafu_notification_on';
  static const String lock_sarafu = 'fsarafu_lock_dev';
  static const String sarafu_lock_timeout = 'fsarafu_lock_timeout';
  // For maximum pin attempts
  static const String pin_attempts = 'fsarafu_pin_attempts';
  static const String pin_lock_until = 'fsarafu_lock_duraton';
  // For certain keystore incompatible androids
  static const String use_legacy_storage = 'fsarafu_legacy_storage';
  // Caching yellowspyglass API response
  static const String yellowspyglass_api_cache =
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
    return set(seed_backed_up_key, value);
  }

  Future<bool> getSeedBackedUp() async {
    return get(seed_backed_up_key, defaultValue: false) as bool;
  }

  Future<void> setFirstLaunch() async {
    return set(first_launch_key, false);
  }

  Future<bool> getFirstLaunch() async {
    return get(first_launch_key, defaultValue: true) as bool;
  }

  Future<void> setFirstContactAdded(bool value) async {
    return set(firstcontact_added, value);
  }

  Future<bool> getFirstContactAdded() async {
    return get(firstcontact_added, defaultValue: false) as bool;
  }

  Future<void> setUuid(String uuid) async {
    return setEncrypted(app_uuid_key, uuid);
  }

  Future<String?> getUuid() async {
    return getEncrypted(app_uuid_key);
  }

  Future<void> setAuthMethod(AuthenticationMethod method) async {
    return set(auth_method, method.getIndex());
  }

  Future<AuthenticationMethod> getAuthMethod() async {
    return AuthenticationMethod(
      AuthMethod.values[
          await get(auth_method, defaultValue: AuthMethod.biometrics.index)
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
    return set(notification_enabled, value);
  }

  Future<bool> getNotificationsOn() async {
    // Notifications off by default on iOS,
    final bool defaultValue;
    if (Platform.isIOS) {
      defaultValue = false;
    } else {
      defaultValue = true;
    }
    return await get(notification_enabled, defaultValue: defaultValue) as bool;
  }

  /// If notifications have been set by user/app
  Future<bool> getNotificationsSet() async {
    final value = get(notification_enabled) as bool?;
    if (value == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> setLock(bool value) async {
    return set(lock_sarafu, value);
  }

  Future<bool> getLock() async {
    return get(lock_sarafu) as bool;
  }

  Future<void> setLockTimeout(LockTimeoutSetting setting) async {
    return set(sarafu_lock_timeout, setting.getIndex());
  }

  Future<LockTimeoutSetting> getLockTimeout() async {
    final value = await get(
      sarafu_lock_timeout,
      defaultValue: LockTimeoutOption.one.index,
    ) as int;
    return LockTimeoutSetting(
      LockTimeoutOption.values[value],
    );
  }

  // Locking out when max pin attempts exceeded
  Future<int> getLockAttempts() async {
    return await get(pin_attempts, defaultValue: 0) as int;
  }

  Future<void> incrementLockAttempts() async {
    await set(pin_attempts, await getLockAttempts() + 1);
  }

  Future<void> resetLockAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
  }

  Future<bool> shouldLock() async {
    if (await get(pin_lock_until) != null || await getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<bool> useLegacyStorage() async {
    return await get(use_legacy_storage, defaultValue: false) as bool;
  }

  Future<void> setUseLegacyStorage() async {
    await set(use_legacy_storage, true);
  }

  Future<void> updateLockDate() async {
    final attempts = await getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      await set(
        pin_lock_until,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(hours: 24))),
      );
    } else if (attempts >= 15) {
      // 3 failed attempts
      await set(
        pin_lock_until,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 15))),
      );
    } else if (attempts >= 10) {
      // 2 failed attempts
      await set(
        pin_lock_until,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 5))),
      );
    } else if (attempts >= 5) {
      await set(
        pin_lock_until,
        DateFormat.yMd()
            .add_jms()
            .format(DateTime.now().toUtc().add(const Duration(minutes: 1))),
      );
    }
  }

  Future<DateTime?> getLockDate() async {
    final lockDateStr = await get(pin_lock_until) as String?;
    if (lockDateStr == null) {
      return null;
    }
    return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
  }

  // For logging out
  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(seed_backed_up_key);
    await prefs.remove(app_uuid_key);
    await prefs.remove(price_conversion);
    await prefs.remove(user_representative);
    await prefs.remove(cur_currency);
    await prefs.remove(auth_method);
    await prefs.remove(notification_enabled);
    await prefs.remove(lock_sarafu);
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
    await prefs.remove(sarafu_lock_timeout);
  }
}
