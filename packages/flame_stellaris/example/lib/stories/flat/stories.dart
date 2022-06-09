import 'package:dashbook/dashbook.dart';
import 'package:example/stories/flat/basic_flat_style_star.dart';
import 'package:example/stories/flat/simple_flat_style_scene.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void addFlatStories(Dashbook dashbook) {
  dashbook.storiesOf('FlatStyle').add(
    'Star',
    (context) {
      return GameWidget(
        game: BasicFlatStyleStarExample(
          starSize: context.numberProperty('size', 50),
          starColor: context.colorProperty(
            'color',
            Colors.orange,
          ),
        ),
      );
    },
  ).add(
    'Starry background',
    (context) {
      return GameWidget(
        game: SimpleFlatStyleScene(),
      );
    },
  );
}
