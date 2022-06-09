import 'package:flame/components.dart';
import 'package:flame_stellaris/flame_stellaris.dart';
import 'package:flame_stellaris/src/effects.dart';
import 'package:flutter/material.dart';

/// {@template flat_stellaris_generator}
/// Generates stellar body in a flat style.
/// {@endtemplate}
class FlatStellarisGenerator extends StellarisGenerator {
  /// {@macro flat_stellaris_generator}
  const FlatStellarisGenerator();

  /// Returns a star in a flat style.
  @override
  PositionComponent generateStar(StarData star) {
    final radius = star.size / 2;
    final glowSize = star.size * 0.1;

    final color = star.color.first;

    return PositionComponent(
      position: star.position,
      anchor: star.anchor,
      size: Vector2.all(star.size),
      children: [
        CircleComponent(
          anchor: Anchor.center,
          radius: radius + glowSize * 3,
          paint: Paint()..color = color.withOpacity(.1),
          children: [GlowEffect(1.1, 1.4)],
        ),
        CircleComponent(
          anchor: Anchor.center,
          radius: radius + glowSize * 2,
          paint: Paint()..color = color.withOpacity(.2),
          children: [GlowEffect(1.1, 1.2)],
        ),
        CircleComponent(
          anchor: Anchor.center,
          radius: radius + glowSize,
          paint: Paint()..color = color.withOpacity(.3),
          children: [GlowEffect(1.1, 1)],
        ),
        CircleComponent(
          anchor: Anchor.center,
          radius: radius,
          paint: Paint()..color = color,
        ),
      ],
    );
  }
}
