// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:mocktail/mocktail.dart';
import 'package:solar_system_repository/solar_system_repository.dart';
import 'package:test/test.dart';

class MockRandom extends Mock implements Random {}

void main() {
  group('SolarSystemRepository', () {
    test('can be instantiated', () {
      expect(SolarSystemRepository(), isNotNull);
    });

    group('getRandomStar', () {
      for (final type in StarType.values) {
        test(
          'return ${type.name} when random returns '
          'less or equals than ${type.definition.probability}',
          () {
            final rng = MockRandom();
            when(rng.nextDouble).thenReturn(type.definition.probability);
            final result = SolarSystemRepository(rng: rng).getRandomStar();

            expect(result.type, equals(type));
            expect(
              result.scale,
              greaterThanOrEqualTo(type.definition.scaleMin),
            );
            expect(
              result.scale,
              lessThanOrEqualTo(type.definition.scaleMax),
            );
          },
        );
      }
    });
  });
}
