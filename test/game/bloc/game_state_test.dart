// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sublight_game/game/game.dart';

void main() {
  group('GameState', () {
    test('can be instantiated', () {
      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: false,
        ),
        isNotNull,
      );
    });

    test('support equality', () {
      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: false,
        ),
        equals(
          GameState(
            population: const {},
            rooms: const {},
            position: Offset.zero,
            moving: false,
          ),
        ),
      );

      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: false,
        ),
        isNot(
          equals(
            GameState(
              population: const {},
              rooms: const {},
              position: Offset(1, 0),
              moving: false,
            ),
          ),
        ),
      );

      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: false,
        ),
        isNot(
          equals(
            GameState(
              population: const {},
              rooms: {Offset.zero: ShipRoom()},
              position: Offset.zero,
              moving: false,
            ),
          ),
        ),
      );

      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: false,
        ),
        isNot(
          equals(
            GameState(
              population: const {},
              rooms: {Offset.zero: ShipRoom(module: ShipModule.bridge)},
              position: Offset.zero,
              moving: false,
            ),
          ),
        ),
      );

      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: false,
        ),
        isNot(
          equals(
            GameState(
              population: const {1: 10},
              rooms: const {},
              position: Offset.zero,
              moving: false,
            ),
          ),
        ),
      );

      expect(
        GameState(
          population: const {},
          rooms: const {},
          position: Offset.zero,
          moving: true,
        ),
        isNot(
          equals(
            GameState(
              population: const {},
              rooms: const {},
              position: Offset.zero,
              moving: false,
            ),
          ),
        ),
      );
    });

    group('copyWith', () {
      test('returns a copy with the new population', () {
        expect(
          GameState(
            population: const {},
            rooms: const {},
            position: Offset.zero,
            moving: false,
          ).copyWith(population: {1: 10}),
          equals(
            GameState(
              population: const {1: 10},
              rooms: const {},
              position: Offset.zero,
              moving: false,
            ),
          ),
        );
      });

      test('returns a copy with the new rooms', () {
        expect(
          GameState(
            population: const {},
            rooms: const {},
            position: Offset.zero,
            moving: false,
          ).copyWith(rooms: {Offset(2, 2): ShipRoom()}),
          equals(
            GameState(
              population: const {},
              rooms: {Offset(2, 2): ShipRoom()},
              moving: false,
              position: Offset.zero,
            ),
          ),
        );
      });

      test('returns a copy with the new position', () {
        expect(
          GameState(
            population: const {},
            rooms: const {},
            position: Offset.zero,
            moving: false,
          ).copyWith(position: Offset(1, 2)),
          equals(
            GameState(
              population: const {},
              rooms: const {},
              moving: false,
              position: Offset(1, 2),
            ),
          ),
        );
      });
    });
  });

  group('ShipModifier', () {
    test('can be instantiated', () {
      expect(
        ShipModifier(space: 0, sblSpeed: 0, impulseSpeed: 0),
        isNotNull,
      );
    });

    test('noEffects return an empty modifier', () {
      expect(
        ShipModifier.noEffects(),
        equals(
          ShipModifier(space: 0, sblSpeed: 0, impulseSpeed: 0),
        ),
      );
    });

    group('copyWith', () {
      test('can copy the instance', () {
        expect(
          ShipModifier.noEffects().copyWith(
            space: 1,
            sblSpeed: 0.2,
            impulseSpeed: 0.2,
          ),
          equals(
            ShipModifier(
              space: 1,
              sblSpeed: 0.2,
              impulseSpeed: 0.2,
            ),
          ),
        );
      });
    });
  });
}
