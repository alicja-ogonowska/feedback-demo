import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';

class MockRemoteValueDataSource implements RemoteValueDataSource {
  @override
  Future<bool?> getBool(String key) async {
    return true;
  }

  @override
  Future<int?> getInt(String key) async {
    return 0;
  }

  @override
  Future<String?> getString(String key) async {
    return "something";
  }
}
