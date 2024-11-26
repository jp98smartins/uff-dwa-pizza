import 'package:shared_preferences/shared_preferences.dart';

abstract base class Storage {
  Future<void> clear(String key);

  Future<void> initStorage();

  String? read(String key);

  Future<void> save(String key, String value);
}

final class AppStorage implements Storage {
  late final SharedPreferences _preferences;

  static final instance = AppStorage._();
  AppStorage._();
  factory AppStorage() => instance;

  @override
  Future<void> clear(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> initStorage() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  String? read(String key) {
    return _preferences.getString(key);
  }

  @override
  Future<void> save(String key, String value) async {
    await _preferences.setString(key, value);
  }
}
