import 'package:feedback_demo/feature/ab_testing/data/model/ab_experiment.dart';

class ExperimentConfig {
  final List<ABExperiment> experiments;
  final BooleanExperiment _addToCartAccentColor;

  ExperimentConfig()
      : _addToCartAccentColor = BooleanExperiment(
          key: "add_to_cart_accent_color",
          defaultValue: false,
        ),
        experiments = [] {
    experiments.add(_addToCartAccentColor);
  }

  bool get useAccentColorCTA => _addToCartAccentColor.value;
}
