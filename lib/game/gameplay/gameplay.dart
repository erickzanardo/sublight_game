import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/components/components.dart';
import 'package:sublight_game/game/navigation/bloc/navigation_cubit.dart';
import 'package:sublight_game/game/timeflow/cubit/timeflow_cubit.dart';

class SublightGameplay extends FlameGame with PanDetector, HasTappables {
  SublightGameplay({
    required this.gameBloc,
    required this.navigationCubit,
    required this.timeflowCubit,
    required this.theme,
  });

  static const navigationPanel = 'NAVIGATION_PANEL';
  static const timeflowPanel = 'TIME_PANEL';
  static const lightYearsRatio = 40.0;

  final ThemeData theme;
  final GameBloc gameBloc;
  final NavigationCubit navigationCubit;
  final TimeflowCubit timeflowCubit;
  late final Timebar _timeBar;

  List<Vector2> _cameraStack = [];

  void pushCameraMovement(Vector2 position) {
    _cameraStack = [
      camera.position.clone(),
      ..._cameraStack,
    ];

    camera.moveTo(position);
  }

  void popCameraMovement() {
    if (_cameraStack.isNotEmpty) {
      final position = _cameraStack.removeAt(0);
      camera.moveTo(position);
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.snapTo(camera.position - info.delta.game);
  }

  @override
  Future<void> onLoad() async {
    final spaceship = SpaceshipComponent(
      position: gameBloc.state.position.toVector2(),
    );

    await addAll(
      [
        StellarisBackground(),
        _timeBar = Timebar(),
        FlameMultiBlocProvider(
          providers: [
            FlameBlocProvider<GameBloc, GameState>.value(
              value: gameBloc,
            ),
            FlameBlocProvider<NavigationCubit, NavigationState>.value(
              value: navigationCubit,
            ),
            FlameBlocProvider<TimeflowCubit, TimeflowState>.value(
              value: timeflowCubit,
            ),
          ],
          children: [
            Timeflow(timeBar: _timeBar),
            spaceship,
            ...navigationCubit.state.systems.map((system) {
              return SolarSystemComponent(
                system: system,
                position: system.position.toVector2() * lightYearsRatio,
              );
            }),
            FlameBlocListener<NavigationCubit, NavigationState>(
              listenWhen: (previous, current) =>
                  previous.target.value != current.target.value,
              onNewState: (state) {
                if (state.target.value != null) {
                  overlays.add(navigationPanel);
                }
              },
            ),
            FlameBlocListener<NavigationCubit, NavigationState>(
              listenWhen: (previous, current) =>
                  previous.target.value != current.target.value,
              onNewState: (state) {
                if (state.target.value == null) {
                  overlays.remove(navigationPanel);
                }
              },
            ),
          ],
        ),
      ],
    );

    camera.snapTo(-size / 2);
  }
}
