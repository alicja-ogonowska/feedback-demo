import 'package:equatable/equatable.dart';

abstract class ABExperiment<T>{
  final String key;
  final T defaultValue;
  T value;

  ABExperiment({required this.key, required this.defaultValue})
      : value = defaultValue;

}

class BooleanExperiment extends ABExperiment<bool> {
  BooleanExperiment({required super.key, required super.defaultValue});
}

class StringExperiment extends ABExperiment<String> {
  StringExperiment({required super.key, required super.defaultValue});
}

class IntExperiment extends ABExperiment<int> {
  IntExperiment({required super.key, required super.defaultValue});
}
