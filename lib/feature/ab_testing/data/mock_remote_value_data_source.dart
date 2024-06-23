import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';

class MockRemoteValueDataSource implements RemoteValueDataSource {
  @override
  bool getBool(String key) {
    return true;
  }

  @override
  int getInt(String key) {
    return 0;
  }

  @override
  String getString(String key) {
    return "something";
  }
}
