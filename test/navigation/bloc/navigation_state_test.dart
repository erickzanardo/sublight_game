// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sublight_game/game/navigation/navigation.dart';

void main() {
  group('NavigationState', () {
    test('can be instantiated', () {
      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<Offset>(null),
        ),
        isNotNull,
      );
    });

    test('supports equality', () {
      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<Offset>(null),
        ),
        equals(
          NavigationState(
            systems: const [],
            selected: NavigationValue<SolarSystem>(null),
            target: NavigationValue<Offset>(null),
          ),
        ),
      );

      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<Offset>(null),
        ),
        isNot(
          equals(
            NavigationState(
              systems: const [SolarSystem(name: 'name', position: Offset.zero)],
              selected: NavigationValue<SolarSystem>(null),
              target: NavigationValue<Offset>(null),
            ),
          ),
        ),
      );

      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<Offset>(null),
        ),
        isNot(
          equals(
            NavigationState(
              systems: const [],
              selected: NavigationValue<SolarSystem>(
                SolarSystem(
                  name: 'name',
                  position: Offset.zero,
                ),
              ),
              target: NavigationValue<Offset>(null),
            ),
          ),
        ),
      );

      expect(
        NavigationState(
          systems: const [],
          selected: NavigationValue<SolarSystem>(null),
          target: NavigationValue<Offset>(null),
        ),
        isNot(
          equals(
            NavigationState(
              systems: const [],
              selected: NavigationValue<SolarSystem>(null),
              target: NavigationValue<Offset>(Offset.zero),
            ),
          ),
        ),
      );
    });
  });
}
