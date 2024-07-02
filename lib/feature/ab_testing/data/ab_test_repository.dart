import 'package:feedback_demo/feature/ab_testing/data/experiment_config.dart';
import 'package:feedback_demo/feature/ab_testing/data/model/ab_experiment.dart';
import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';

class ABTestRepository {
  final RemoteValueDataSource dataSource;

  ABTestRepository({required this.dataSource});

  Future<T> getExperimentValue<T>(ABExperiment<T> experiment) async {
    Future<T?>? valueFuture;
    if (experiment is BooleanExperiment) {
      valueFuture = dataSource.getBool(experiment.key) as Future<T?>?;
    } else if (experiment is StringExperiment) {
      valueFuture = dataSource.getString(experiment.key) as Future<T?>?;
    } else if (experiment is IntExperiment) {
      valueFuture = dataSource.getInt(experiment.key) as Future<T?>?;
    } else {
      throw UnsupportedError('Unsupported experiment type');
    }

    return (await valueFuture) ?? experiment.defaultValue;
  }

  Future<ExperimentConfig> getExperimentValues(ExperimentConfig config) async {
    await Future.wait(config.experiments.map((experiment) async {
      experiment.value = await getExperimentValue(experiment);
    }));
    return config;
  }
}
