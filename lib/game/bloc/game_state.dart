part of 'game_bloc.dart';

class ShipModifier extends Equatable {
  const ShipModifier({
    required this.space,
    required this.sblSpeed,
    required this.impulseSpeed,
  });

  const ShipModifier.noEffects()
      : this(
          space: 0,
          sblSpeed: 0,
          impulseSpeed: 0,
        );

  final int space;
  final double sblSpeed;
  final double impulseSpeed;

  ShipModifier copyWith({
    int? space,
    double? sblSpeed,
    double? impulseSpeed,
  }) {
    return ShipModifier(
      space: space ?? this.space,
      sblSpeed: sblSpeed ?? this.sblSpeed,
      impulseSpeed: impulseSpeed ?? this.impulseSpeed,
    );
  }

  @override
  List<Object?> get props => [space, sblSpeed, impulseSpeed];
}

enum ShipModule {
  bridge(ShipModifier.noEffects()),
  livingQuarters(ShipModifier(space: 20, sblSpeed: 0, impulseSpeed: 0)),
  sblDriver(ShipModifier(space: 0, sblSpeed: 0.1, impulseSpeed: 0)),
  impulseDriver(ShipModifier(space: 0, sblSpeed: 0, impulseSpeed: 0.2));

  const ShipModule(this.modifier);

  final ShipModifier modifier;
}

class ShipRoom extends Equatable {
  const ShipRoom({this.module});

  final ShipModule? module;

  @override
  List<Object?> get props => [module];
}

class GameState extends Equatable {
  const GameState({
    required this.population,
    required this.rooms,
    required this.position,
  });

  final Map<int, int> population;
  final Map<Offset, ShipRoom> rooms;
  final Offset position;

  GameState copyWith({
    Map<int, int>? population,
    Map<Offset, ShipRoom>? rooms,
    Offset? position,
  }) {
    return GameState(
      population: population ?? this.population,
      rooms: rooms ?? this.rooms,
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [
        population,
        rooms,
        position,
      ];
}
