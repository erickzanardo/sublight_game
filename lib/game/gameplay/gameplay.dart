import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/components/components.dart';
import 'package:sublight_game/game/navigation/bloc/navigation_cubit.dart';

class SublightGameplay extends FlameGame {
  SublightGameplay({
    required this.gameBloc,
    required this.navigationCubit,
  });

  static const lightYearsRatio = 40.0;

  final GameBloc gameBloc;
  final NavigationCubit navigationCubit;

  @override
  Future<void> onLoad() async {
    final spaceship = SpaceshipComponent(
      position: gameBloc.state.position.toVector2(),
    );
    await add(spaceship);
    camera.followComponent(spaceship);

    await addAll(
      navigationCubit.state.systems.map((system) {
        return SolarSystemComponent(
          position: system.position.toVector2() * lightYearsRatio,
        );
      }),
    );
  }
}
