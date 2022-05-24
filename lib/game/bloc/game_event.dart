part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class YearPassed extends GameEvent {
  @override
  List<Object> get props => [];
}
