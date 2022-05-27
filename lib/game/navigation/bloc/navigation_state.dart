part of 'navigation_cubit.dart';

class SolarSystem extends Equatable {
  const SolarSystem({
    required this.name,
    required this.position,
  });

  final String name;
  final Offset position;

  @override
  List<Object> get props => [name, position];
}

class NavigationState extends Equatable {
  const NavigationState({
    required this.systems,
    this.target,
  });

  final List<SolarSystem> systems;
  final Offset? target;

  @override
  List<Object?> get props => [systems, target];
}
