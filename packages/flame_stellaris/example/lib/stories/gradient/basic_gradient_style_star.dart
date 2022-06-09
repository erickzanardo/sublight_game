import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_stellaris/flame_stellaris.dart';

class BasicGradientStyleStarExample extends FlameGame {
  BasicGradientStyleStarExample({
    required this.starSize,
    required this.starColor,
    required this.starSecondaryColor,
  });

  final double starSize;
  final Color starColor;
  final Color starSecondaryColor;

  @override
  Future<void> onLoad() async {
    const flatCreator = GradientStellarisGenerator();
    await add(
      flatCreator.generateStar(
        StarData(
          size: starSize,
          color: [starColor, starSecondaryColor],
          anchor: Anchor.center,
        ),
      ),
    );

    camera.followVector2(Vector2.zero());
  }
}
