abstract class RemoteValueDataSource {
  Future<String?> getString(String key);

  Future<int?> getInt(String key);

  Future<bool?> getBool(String key);
}
