import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../uuid/app_uuid.dart';
import 'app_storage.dart';

/// All platforms are able to use this storage.
///
/// [ Android ]: MinSdkVersion 18 | on `AndroidManifest.xml` add `android:allowBackup="false"` and `android:fullBackupContent="false"`
/// [ MacOS ]: on `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements` add `<key>keychain-access-groups</key><array/>`
abstract base class SecureStorage {
  Future<void> clear(String key);

  Future<void> initSecureStorage(Storage storage);

  Future<String?> read(String key);

  Future<void> save(String key, String? value);
}

final class AppSecureStorage implements SecureStorage {
  static const String _secureKeyName = 'ce86b01a-9635-4553-b591-d5804cfee3d8';

  late final FlutterSecureStorage _secureStorage;

  /// Using an key saved on the preferences storage to garantee that the
  /// secure storage will be erased if the app is uninstalled.
  /// https://forums.developer.apple.com/forums/thread/36442
  late final String _secureKey;

  static final instance = AppSecureStorage._();
  AppSecureStorage._();
  factory AppSecureStorage() => instance;

  @override
  Future<void> clear(String key) {
    return _secureStorage.delete(key: '$_secureKey$key');
  }

  @override
  Future<void> initSecureStorage(Storage storage) async {
    // Initializing the Secure Storage
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'f8b1b55d-16c4-4af2-bcb7-35aea56ddf5e',
    );
    _secureStorage = const FlutterSecureStorage(aOptions: androidOptions);

    // Saving the Secure Key
    final key = storage.read(_secureKeyName);
    if (key != null) {
      _secureKey = key;
    } else {
      _secureKey = AppUuidImpl().generate();
      await storage.save(_secureKeyName, _secureKey);
    }
  }

  @override
  Future<String?> read(String key) {
    return _secureStorage.read(key: '$_secureKey$key');
  }

  @override
  Future<void> save(String key, String? value) {
    return _secureStorage.write(key: '$_secureKey$key', value: value);
  }
}
