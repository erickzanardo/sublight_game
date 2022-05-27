import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/components/components.dart';

class SublightGameplay extends FlameGame {
  SublightGameplay({
    required this.gameBloc,
  });

  final GameBloc gameBloc;

  @override
  Future<void> onLoad() async {
    final spaceship = Spaceship(
      position: gameBloc.state.position.toVector2(),
    );
    await add(spaceship);
    camera.followComponent(spaceship);
  }
}
