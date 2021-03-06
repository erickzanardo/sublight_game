// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:solar_system_repository/solar_system_repository.dart';
import 'package:sublight_game/game/navigation/navigation.dart';

void main() {
  group('NavigationState', () {
    test('can be instantiated', () {
      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<SolarSystem>(null),
        ),
        isNotNull,
      );
    });

    test('supports equality', () {
      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<SolarSystem>(null),
        ),
        equals(
          NavigationState(
            systems: const [],
            selected: NavigationValue<SolarSystem>(null),
            target: NavigationValue<SolarSystem>(null),
          ),
        ),
      );

      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<SolarSystem>(null),
        ),
        isNot(
          equals(
            NavigationState(
              systems: const [
                SolarSystem(
                  name: 'name',
                  position: Offset.zero,
                  star: Star(type: StarType.o, scale: 1),
                ),
              ],
              selected: NavigationValue<SolarSystem>(null),
              target: NavigationValue<SolarSystem>(null),
            ),
          ),
        ),
      );

      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<SolarSystem>(null),
        ),
        isNot(
          equals(
            NavigationState(
              systems: const [],
              selected: NavigationValue<SolarSystem>(
                SolarSystem(
                  name: 'name',
                  position: Offset.zero,
                  star: Star(type: StarType.o, scale: 1),
                ),
              ),
              target: NavigationValue<SolarSystem>(null),
            ),
          ),
        ),
      );

      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<SolarSystem>(null),
        ),
        isNot(
          equals(
            NavigationState(
              systems: const [],
              selected: NavigationValue<SolarSystem>(null),
              target: NavigationValue<SolarSystem>(
                SolarSystem(
                  name: 'name',
                  position: Offset.zero,
                  star: Star(type: StarType.o, scale: 1),
                ),
              ),
            ),
          ),
        ),
      );
    });
  });
}
