import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/components/components.dart';
import 'package:sublight_game/game/navigation/bloc/navigation_cubit.dart';

class SublightGameplay extends FlameGame with PanDetector, HasTappables {
  SublightGameplay({
    required this.gameBloc,
    required this.navigationCubit,
  });

  static const lightYearsRatio = 40.0;

  final GameBloc gameBloc;
  final NavigationCubit navigationCubit;

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.snapTo(camera.position - info.delta.game);
  }

  @override
  Future<void> onLoad() async {
    final spaceship = SpaceshipComponent(
      position: gameBloc.state.position.toVector2(),
    );

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameBloc, GameState>.value(
            value: gameBloc,
          ),
          FlameBlocProvider<NavigationCubit, NavigationState>.value(
            value: navigationCubit,
          ),
        ],
        children: [
          spaceship,
          ...navigationCubit.state.systems.map((system) {
            return SolarSystemComponent(
              system: system,
              position: system.position.toVector2() * lightYearsRatio,
            );
          }),
        ],
      ),
    );

    camera.snapTo(-size / 2);
  }
}
