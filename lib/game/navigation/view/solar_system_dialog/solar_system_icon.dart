import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_stellaris/flame_stellaris.dart';
import 'package:flutter/material.dart';
import 'package:solar_system_repository/solar_system_repository.dart';
import 'package:sublight_game/game/extensions/star.dart';

class _SingleChildGame extends FlameGame {
  _SingleChildGame(PositionComponent component) : super(children: [component]);

  @override
  Future<void> onLoad() async {
    camera.followVector2(Vector2.zero());
  }

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }
}

class _SolarSystemStar extends PositionComponent with HasGameRef {
  _SolarSystemStar(this.star);

  final Star star;

  @override
  Future<void> onLoad() async {
    size = gameRef.size;
    const flameStellaris = FlatStellarisGenerator();
    await add(
      flameStellaris.generateStar(
        StarData(
          position: size / 2,
          size: size.x,
          color: star.palette,
          anchor: Anchor.center,
        ),
      ),
    );
  }
}

class SolarSystemIcon extends StatefulWidget {
  const SolarSystemIcon({super.key, required this.star});

  final Star star;

  @override
  State<StatefulWidget> createState() {
    return _SolarSystemIconState();
  }
}

class _SolarSystemIconState extends State<SolarSystemIcon> {
  late final FlameGame _game;

  @override
  void initState() {
    super.initState();

    _game = _SingleChildGame(_SolarSystemStar(widget.star));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: GameWidget(
          game: _game,
        ),
      ),
    );
  }
}
