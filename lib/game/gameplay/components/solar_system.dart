import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class SolarSystemComponent extends CircleComponent {
  SolarSystemComponent({super.position})
      : super(
          paint: Paint()..color = Colors.yellow,
          anchor: Anchor.center,
          radius: 15,
        );
}
