import 'package:flame/components.dart';
import 'package:flame_stellaris/flame_stellaris.dart';
import 'package:flame_stellaris/src/effects.dart';
import 'package:flutter/material.dart';

class _GradientCircle extends CircleComponent {
  _GradientCircle({
    required double radius,
    required Color color,
    required Color secondaryColor,
    required int priority,
    Iterable<Component> children = const [],
  }) : super(
          anchor: Anchor.center,
          radius: radius,
          priority: priority,
          paint: Paint()
            ..shader = RadialGradient(
              colors: [
                secondaryColor,
                color,
              ],
            ).createShader(
              Rect.fromCircle(
                center: Offset(radius, radius),
                radius: radius,
              ),
            ),
          children: children,
        );
}

/// {@template gradient_stellaris_generator}
/// Generates stellar bodies in a gradien style.
/// {@endtemplate}
class GradientStellarisGenerator extends StellarisGenerator {
  /// {@macro gradient_stellaris_generator}
  const GradientStellarisGenerator();

  @override
  PositionComponent generateStar(StarData star) {
    final radius = star.size / 2;
    final glowSize = star.size * 0.1;

    final color = star.color.first;
    final secondaryColor = star.color.length > 1 ? star.color[1] : Colors.white;

    late PositionComponent component;
    // ignore: join_return_with_assignment
    component = PositionComponent(
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
        _GradientCircle(
          radius: radius,
          priority: 1,
          color: color,
          secondaryColor: secondaryColor,
        ),
      ],
    );

    return component;
  }
}
