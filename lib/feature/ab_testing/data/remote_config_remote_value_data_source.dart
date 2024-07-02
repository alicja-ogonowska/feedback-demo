import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRemoteValueDataSource implements RemoteValueDataSource {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Map<String, RemoteConfigValue>? _values;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 30),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await _fetchRemoteConfig();
  }

  Future<void> _fetchRemoteConfig() async {
    await _remoteConfig.fetchAndActivate();
    _values = _remoteConfig.getAll();
  }

  @override
  Future<bool?> getBool(String key) async {
    return _values?[key]?.asBool();
  }

  @override
  Future<int?> getInt(String key) async {
    return _values?[key]?.asInt();
  }

  @override
  Future<String?> getString(String key) async {
    return _values?[key]?.asString();
  }
}
