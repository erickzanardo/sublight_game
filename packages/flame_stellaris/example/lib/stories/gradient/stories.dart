import 'package:dashbook/dashbook.dart';
import 'package:example/stories/gradient/basic_gradient_style_star.dart';
import 'package:example/stories/gradient/simple_gradient_style_scene.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void addGradientStories(Dashbook dashbook) {
  dashbook.storiesOf('GradientStyle').add(
    'Star',
    (context) {
      return GameWidget(
        game: BasicGradientStyleStarExample(
          starSize: context.numberProperty('size', 50),
          starColor: context.colorProperty(
            'color',
            Colors.orange,
          ),
          starSecondaryColor: context.colorProperty(
            'second color',
            Colors.yellow,
          ),
        ),
      );
    },
  ).add(
    'Starry background',
    (context) {
      return GameWidget(
        game: SimpleGradientStyleScene(),
      );
    },
  );
}
