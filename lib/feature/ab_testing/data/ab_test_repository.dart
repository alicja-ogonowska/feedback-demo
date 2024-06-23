import 'package:feedback_demo/feature/ab_testing/data/experiment_config.dart';
import 'package:feedback_demo/feature/ab_testing/data/model/ab_experiment.dart';
import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';

class ABTestRepository {
  final RemoteValueDataSource dataSource;

  ABTestRepository({required this.dataSource});

  T getExperimentValue<T>(ABExperiment<T> experiment) {
    late T? value;
    if (experiment is BooleanExperiment) {
      value = dataSource.getBool(experiment.key) as T?;
    } else if (experiment is StringExperiment) {
      value = dataSource.getString(experiment.key) as T?;
    } else if (experiment is IntExperiment) {
      value = dataSource.getInt(experiment.key) as T?;
    } else {
      throw UnsupportedError('Unsupported experiment type');
    }
    return value ?? experiment.defaultValue;
  }

  ExperimentConfig getExperimentValues(ExperimentConfig config) {
    for (var experiment in config.experiments) {
      experiment.value = getExperimentValue(experiment);
    }
    return config;
  }
}
