import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Spaceship extends CircleComponent {
  Spaceship({super.position})
      : super(
          paint: Paint()..color = Colors.blue,
          anchor: Anchor.center,
          radius: 5,
        );
}
