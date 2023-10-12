import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class SharedPreferencesLocalStorage implements LocalStorage {
  const SharedPreferencesLocalStorage._();

  static SharedPreferencesLocalStorage instance =
      const SharedPreferencesLocalStorage._();

  @override
  Future<String?> getString(String key) async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  @override
  Future<void> setString(String key, {required String value}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool(key);
  }

  @override
  Future<void> setBool(String key, {required bool value}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    final instance = await SharedPreferences.getInstance();
    return instance.getInt(key);
  }

  @override
  Future<void> setInt(String key, {required int value}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(key, value);
  }
  
  @override
  Future<void> clean(String key) async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove(key);
  }
}
