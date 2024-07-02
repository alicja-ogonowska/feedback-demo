import 'package:equatable/equatable.dart';
import 'package:feedback_demo/feature/ab_testing/data/ab_test_repository.dart';
import 'package:feedback_demo/feature/ab_testing/data/experiment_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ABTestCubit extends Cubit<ABTestState> {
  final ABTestRepository repository;
  final ExperimentConfig config;

  ABTestCubit({
    required this.repository,
    required this.config,
  }) : super(ABTestState(config));

  void loadExperiments() async {
    final result = await repository.getExperimentValues(config);
    emit(ABTestState(result));
  }
}

class ABTestState extends Equatable {
  final ExperimentConfig config;

  const ABTestState(this.config);

  @override
  List<Object?> get props => [config];
}
