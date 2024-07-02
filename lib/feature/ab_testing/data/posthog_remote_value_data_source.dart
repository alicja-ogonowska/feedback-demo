import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

class PosthogRemoteValueDataSource implements RemoteValueDataSource {
  final Posthog _posthog = Posthog();

  @override
  Future<bool?> getBool(String key) async {
    return await _posthog.getFeatureFlag(key) as String == 'A';
  }

  @override
  Future<int?> getInt(String key) async {
    return int.tryParse((await _posthog.getFeatureFlag(key)) as String);
  }

  @override
  Future<String?> getString(String key) async {
    return (await _posthog.getFeatureFlag(key)) as String?;
  }
}
