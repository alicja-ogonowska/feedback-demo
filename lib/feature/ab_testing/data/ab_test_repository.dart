import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';
import 'package:feedback_demo/feature/ab_testing/data/experiment_config.dart';
import 'package:feedback_demo/feature/ab_testing/data/model/ab_experiment.dart';

class ABTestRepository {
  final RemoteValueDataSource dataSource;

  ABTestRepository({required this.dataSource});

  T getExperimentValue<T>(ABExperiment<T> experiment) {
    if (experiment is BooleanExperiment) {
      return dataSource.getBool(experiment.key) as T;
    } else if (experiment is StringExperiment) {
      return dataSource.getString(experiment.key) as T;
    } else if (experiment is IntExperiment) {
      return dataSource.getInt(experiment.key) as T;
    } else {
      throw UnsupportedError('Unsupported experiment type');
    }
  }

  ExperimentConfig getExperimentValues(ExperimentConfig config) {
    for (var experiment in config.experiments) {
      experiment.value = getExperimentValue(experiment);
    }
    return config;
  }
}
