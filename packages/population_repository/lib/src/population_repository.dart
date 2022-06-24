import 'dart:math';

import 'package:population_repository/src/mappings.dart';

/// {@template population_repository}
/// Population repository package
/// {@endtemplate}
class PopulationRepository {
  /// {@macro population_repository}
  PopulationRepository({Random? rng}) {
    _rng = rng ?? Random();
  }

  late final Random _rng;

  /// Return the number of casualities at a given age.
  int calculateNaturalCausesCasualities(int age, int population) {
    final ageRisk = naturalDeathRiskMapping(age);
    return List.generate(
      population,
      (index) => _rng.nextDouble() < ageRisk.percent,
    ).where((value) => value).length;
  }

  /// Returns the number of births of the current population.
  int calculateBirths(Map<int, int> population) {
    final totalPairs = population.entries
            .where((entry) => entry.key >= 20 && entry.key <= 40)
            .fold<int>(
              0,
              (previousValue, entry) => previousValue + entry.value,
            ) ~/
        2;

    return List.generate(totalPairs, (index) => _rng.nextDouble() < 0.1)
        .where((value) => value)
        .length;
  }
}
