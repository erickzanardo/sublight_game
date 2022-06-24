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
}
