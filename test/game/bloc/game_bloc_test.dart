import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:population_repository/population_repository.dart';
import 'package:sublight_game/game/game.dart';

class _MockPopulationRepository extends Mock implements PopulationRepository {}

void main() {
  group('GameBloc', () {
    late PopulationRepository populationRepository;

    setUp(() {
      populationRepository = _MockPopulationRepository();
      when(() => populationRepository.calculateCasualities(any()))
          .thenReturn(0);
    });

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
        populationRepository: populationRepository,
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

    blocTest<GameBloc, GameState>(
      'population can suffers casualities on YearPassed',
      setUp: () {
        when(() => populationRepository.calculateCasualities(10))
            .thenReturn(0.2);
      },
      build: () => GameBloc(
        state: const GameState(
          space: 10,
          speed: 0.1,
          population: {
            10: 10,
            11: 10,
          },
        ),
        populationRepository: populationRepository,
      ),
      act: (bloc) => bloc.add(YearPassed()),
      expect: () => [
        const GameState(
          space: 10,
          speed: 0.1,
          population: {
            11: 8,
            12: 10,
          },
        ),
      ],
    );
  });
}
