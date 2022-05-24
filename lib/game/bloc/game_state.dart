part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.space,
    required this.speed,
    required this.population,
  });

  const GameState.initial()
      : this(
          space: 1000,
          speed: 0.2,
          population: const {
            20: 10,
            21: 10,
            22: 10,
            23: 10,
            24: 10,
            25: 10,
            26: 10,
            27: 10,
            28: 10,
            29: 10,
            30: 10,
            31: 10,
            32: 10,
            33: 10,
            34: 10,
            35: 10,
          },
        );

  final int space;
  final double speed;
  final Map<int, int> population;

  GameState copyWith({
    int? space,
    double? speed,
    Map<int, int>? population,
  }) {
    return GameState(
      space: space ?? this.space,
      speed: speed ?? this.speed,
      population: population ?? this.population,
    );
  }

  @override
  List<Object> get props => [
        space,
        speed,
        population,
      ];
}
