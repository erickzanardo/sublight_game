import 'package:flutter_test/flutter_test.dart';
import 'package:sublight_game/game/game.dart';

void main() {
  group('GameEvent', () {
    group('YearPassed', () {
      test('can be instantiated', () {
        expect(YearPassed(), isNotNull);
      });

      test('supports equality', () {
        expect(YearPassed(), equals(YearPassed()));
      });
    });
  });
}
