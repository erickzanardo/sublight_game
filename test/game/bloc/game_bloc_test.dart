import 'package:bloc_test/bloc_test.dart';
import 'package:sublight_game/game/game.dart';

void main() {
  blocTest<GameBloc, GameState>(
    'population gets older on YearPassed',
    build: () => GameBloc(
      state: const GameState(
        space: 10,
        speed: 0.1,
        population: {
          10: 10,
          11: 10,
        },
      ),
    ),
    act: (bloc) => bloc.add(YearPassed()),
    expect: () => [
      const GameState(
        space: 10,
        speed: 0.1,
        population: {
          11: 10,
          12: 10,
        },
      ),
    ],
  );
}
