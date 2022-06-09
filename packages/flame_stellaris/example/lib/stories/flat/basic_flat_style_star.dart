import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_stellaris/flame_stellaris.dart';

class BasicFlatStyleStarExample extends FlameGame {
  BasicFlatStyleStarExample({
    required this.starSize,
    required this.starColor,
  });

  final double starSize;
  final Color starColor;

  @override
  Future<void> onLoad() async {
    const flatCreator = FlatStellarisGenerator();
    await add(
      flatCreator.generateStar(
        StarData(
          size: starSize,
          color: [starColor],
          anchor: Anchor.center,
        ),
      ),
    );

    camera.followVector2(Vector2.zero());
  }
}
