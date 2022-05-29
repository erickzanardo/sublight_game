import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(super.initialState);

  void selectSolarSystem(SolarSystem solarSystem) {
    emit(
      state.copyWith(
        selected: NavigationValue<SolarSystem>(solarSystem),
      ),
    );
  }

  void unselectSolarSystem() {
    emit(
      state.copyWith(
        selected: const NavigationValue<SolarSystem>(null),
      ),
    );
  }

  void setTarget(SolarSystem value) {
    emit(
      state.copyWith(
        target: NavigationValue<SolarSystem>(value),
        selected: const NavigationValue<SolarSystem>(null),
      ),
    );
  }

  void removeTarget() {
    emit(
      state.copyWith(
        target: const NavigationValue<SolarSystem>(null),
      ),
    );
  }
}
