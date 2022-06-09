import 'dart:math';

import 'package:solar_system_repository/solar_system_repository.dart';

/// {@template solar_system_repository}
/// Repository concerning stars and planets
/// {@endtemplate}
class SolarSystemRepository {
  /// {@macro solar_system_repository}
  SolarSystemRepository({Random? rng}) {
    _rng = rng ?? Random();
  }

  late final Random _rng;

  /// Returns a random [StarType] based on its probability.
  StarType getRandomStarType() {
    final value = _rng.nextDouble();
    final values = [...StarType.values]..sort((a, b) {
        if (a.definition.probability > b.definition.probability) return 1;
        if (a.definition.probability < b.definition.probability) return -1;
        return 0;
      });

    for (final type in values) {
      if (value <= type.definition.probability) {
        return type;
      }
    }

    return StarType.m;
  }
}
