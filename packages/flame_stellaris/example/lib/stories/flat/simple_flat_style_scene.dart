import 'package:flame/game.dart';
import 'package:flame_stellaris/flame_stellaris.dart';
import 'package:flutter/material.dart';

class SimpleFlatStyleScene extends FlameGame {
  @override
  Future<void> onLoad() async {
    const flatCreator = FlatStellarisGenerator();

    await addAll([
      flatCreator.generateStarryBackground(size: size),
      flatCreator.generateStar(
        StarData(
          size: 20,
          color: [Colors.pink],
          position: size * 0.3,
        ),
      ),
      flatCreator.generateStar(
        StarData(
          size: 100,
          color: [Colors.blueAccent],
          position: size * 0.7,
        ),
      ),
      flatCreator.generateStar(
        StarData(
          size: 40,
          color: [Colors.yellowAccent],
          position: Vector2(size.x * 0.3, size.y * 0.5),
        ),
      ),
      flatCreator.generateStar(
        StarData(
          size: 80,
          color: [Colors.deepPurple],
          position: Vector2(size.x * 0.8, size.y * 0.2),
        ),
      ),
    ]);
  }
}
