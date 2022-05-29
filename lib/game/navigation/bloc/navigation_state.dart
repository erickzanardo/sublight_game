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

class NavigationValue<T> extends Equatable {
  const NavigationValue(this.value);

  final T? value;

  @override
  List<Object?> get props => [value];
}

class NavigationState extends Equatable {
  const NavigationState({
    required this.systems,
    required this.selected,
    required this.target,
  });

  final List<SolarSystem> systems;
  final NavigationValue<SolarSystem> selected;
  final NavigationValue<SolarSystem> target;

  NavigationState copyWith({
    List<SolarSystem>? systems,
    NavigationValue<SolarSystem>? selected,
    NavigationValue<SolarSystem>? target,
  }) {
    return NavigationState(
      systems: systems ?? this.systems,
      selected: selected ?? this.selected,
      target: target ?? this.target,
    );
  }

  @override
  List<Object?> get props => [systems, selected, target];
}
