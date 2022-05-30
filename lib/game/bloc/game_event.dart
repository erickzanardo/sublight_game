part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class YearPassed extends GameEvent {
  @override
  List<Object> get props => [];
}

class DriveEngaged extends GameEvent {
  @override
  List<Object> get props => [];
}

class DriveDisengaged extends GameEvent {
  const DriveDisengaged(this.position);

  final Offset position;

  @override
  List<Object> get props => [position];
}
