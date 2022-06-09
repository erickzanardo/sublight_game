import 'package:fast_noise/fast_noise.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// {@template star_data}
/// Model class that defines the data for a star.
/// {@endtemplate}
class StarData {
  /// {@macro star_data}
  StarData({
    required this.size,
    required this.color,
    this.position,
    this.anchor,
  }) : assert(color.isNotEmpty, 'At least one color must be specified');

  /// Total size of the star
  final double size;

  /// List of colors to be used on the star generation.
  /// The amount of colors must always be at least 1 and the
  /// amount of colors supported depends on the generator used,
  /// be sur to check the docs for the generators for more informtion.
  final List<Color> color;

  /// Position of the star.
  final Vector2? position;

  /// Anchor of the star.
  final Anchor? anchor;
}

/// {@template flat_stellaris_generator}
/// Generates stellar body in a flat style.
/// {@endtemplate}
abstract class StellarisGenerator {
  /// {@macro flat_stellaris_generator}
  const StellarisGenerator();

  /// Returns a star in a flat style.
  PositionComponent generateStar(StarData star);

  /// Generates a starry background.
  PositionComponent generateStarryBackground({
    required Vector2 size,
    Vector2? position,
    Anchor? anchor,
  }) {
    final finalSize = size / 20;

    final arr2d = noise2(
      finalSize.x.toInt(),
      finalSize.y.toInt(),
      noiseType: NoiseType.PerlinFractal,
      octaves: 4,
      frequency: 0.8,
    );

    final paint = Paint()..color = Colors.white;

    return PositionComponent(
      position: position,
      anchor: anchor,
      children: [
        for (int x = 0; x < arr2d.length; x++)
          for (int y = 0; y < arr2d[y].length; y++)
            if (arr2d[x][y].abs() > 0.3)
              CircleComponent(
                anchor: Anchor.center,
                radius: arr2d[x][y] > 0 ? 2 : 1,
                position: Vector2(x * 20, y * 20),
                paint: paint,
              ),
      ],
    );
  }
}
