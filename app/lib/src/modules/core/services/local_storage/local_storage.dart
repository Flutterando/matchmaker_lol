abstract class LocalStorage {
  Future<String?> getString(String key);
  Future<void> setString(String key, {required String value});

  Future<bool?> getBool(String key);
  Future<void> setBool(String key, {required bool value});

  Future<int?> getInt(String key);
  Future<void> setInt(String key, {required int value});

  Future<void> clean(String key);
}
