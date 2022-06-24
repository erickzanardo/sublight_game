part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.population,
    required this.rooms,
    required this.position,
    required this.moving,
    required this.year,
  });

  final Map<int, int> population;
  final Map<Offset, ShipRoom> rooms;
  final Offset position;
  final bool moving;
  final int year;

  ShipModifier get modifier {
    return rooms.values.fold(
      const ShipModifier.noEffects(),
      (previousValue, element) {
        final otherModifier =
            element.module?.modifier ?? const ShipModifier.noEffects();

        return previousValue + otherModifier;
      },
    );
  }

  int get totalPopulation {
    return population.values.fold(
      0,
      (previousValue, element) => previousValue + element,
    );
  }

  GameState copyWith({
    Map<int, int>? population,
    Map<Offset, ShipRoom>? rooms,
    Offset? position,
    bool? moving,
    int? year,
  }) {
    return GameState(
      population: population ?? this.population,
      rooms: rooms ?? this.rooms,
      position: position ?? this.position,
      moving: moving ?? this.moving,
      year: year ?? this.year,
    );
  }

  @override
  List<Object> get props => [
        population,
        rooms,
        position,
        moving,
        year,
      ];
}
