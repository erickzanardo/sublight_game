import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({GameState state = const GameState.initial()}) : super(state) {
    on<YearPassed>(_onYearPassed);
  }

  void _onYearPassed(
    YearPassed event,
    Emitter<GameState> emit,
  ) {
    final updatedPopulation = <int, int>{};

    for (final entry in state.population.entries) {
      updatedPopulation[entry.key + 1] = entry.value;
    }

    emit(state.copyWith(population: updatedPopulation));
  }
}
