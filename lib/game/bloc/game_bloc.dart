import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame/extensions.dart';
import 'package:population_repository/population_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({
    GameState state = const GameState(
      population: {},
      rooms: {},
      position: Offset.zero,
      moving: false,
      year: 1,
    ),
    PopulationRepository populationRepository = const PopulationRepository(),
  })  : _populationRepository = populationRepository,
        super(state) {
    on<YearPassed>(_onYearPassed);
    on<DriveEngaged>(_onDriveEngaged);
    on<DriveDisengaged>(_onDriveDisengaged);
    on<PositionReported>(_onPositionReported);
  }

  final PopulationRepository _populationRepository;

  void _onYearPassed(
    YearPassed event,
    Emitter<GameState> emit,
  ) {
    final updatedPopulation = <int, int>{};

    for (final entry in state.population.entries) {
      final casualities = _populationRepository.calculateCasualities(
        entry.key,
      );

      updatedPopulation[entry.key + 1] = entry.value - casualities;
    }

    emit(
      state.copyWith(
        population: updatedPopulation,
        year: state.year + 1,
      ),
    );
  }

  void _onDriveEngaged(
    DriveEngaged event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(moving: true));
  }

  void _onDriveDisengaged(
    DriveDisengaged event,
    Emitter<GameState> emit,
  ) {
    emit(
      state.copyWith(
        moving: false,
        position: event.position,
      ),
    );
  }

  void _onPositionReported(
    PositionReported event,
    Emitter<GameState> emit,
  ) {
    emit(
      state.copyWith(
        position: event.position,
      ),
    );
  }
}
