import 'package:feedback_demo/feature/ab_testing/data/model/ab_experiment.dart';

class ExperimentConfig {
  final List<ABExperiment> experiments;
  final BooleanExperiment addToCartAccentColor;

  ExperimentConfig()
      : addToCartAccentColor = BooleanExperiment(
          key: "add_to_cart_accent_color",
          defaultValue: false,
        ),
        experiments = [] {
    experiments.add(addToCartAccentColor);
  }

  bool get addToCartAccentColorValue => addToCartAccentColor.value;
}
