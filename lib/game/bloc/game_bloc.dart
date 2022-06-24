import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame/extensions.dart';
import 'package:population_repository/population_repository.dart';
import 'package:sublight_game/game/models/models.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({
    GameState state = const GameState(
      population: <int, int>{},
      rooms: <Offset, ShipRoom>{},
      position: Offset.zero,
      moving: false,
      year: 1,
    ),
    PopulationRepository? populationRepository,
  }) : super(state) {
    on<YearPassed>(_onYearPassed);
    on<DriveEngaged>(_onDriveEngaged);
    on<DriveDisengaged>(_onDriveDisengaged);
    on<PositionReported>(_onPositionReported);
    _populationRepository = populationRepository ?? PopulationRepository();
  }

  late final PopulationRepository _populationRepository;

  void _onYearPassed(
    YearPassed event,
    Emitter<GameState> emit,
  ) {
    final updatedPopulation = <int, int>{};

    for (final entry in state.population.entries) {
      final casualities =
          _populationRepository.calculateNaturalCausesCasualities(
        entry.key,
        entry.value,
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
