import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';

const dialogRate = 0.4;
const bottomSheetRate = 0.8;

extension BuildContextReponsiveX on BuildContext {
  bool isVerticalScreen() {
    final mediaQuery = MediaQuery.of(this);

    return mediaQuery.size.height > mediaQuery.size.width;
  }

  double dialogWidth() {
    final mediaQuery = MediaQuery.of(this);
    return mediaQuery.size.width * dialogRate;
  }

  double bottomSheetHeight() {
    final mediaQuery = MediaQuery.of(this);
    return mediaQuery.size.height * bottomSheetRate;
  }
}

extension FlameGameResponsiveX on SublightGameplay {
  void dialogFocus(PositionComponent component) {
    final availableSpace = size.x - size.x * dialogRate;

    camera.speed = 1000;
    pushCameraMovement(
      component.position -
          Vector2(
            availableSpace / 2,
            size.y / 2,
          ),
    );
  }

  void bottomSheetFocus(PositionComponent component) {
    final availableSpace = size.y - size.y * bottomSheetRate;

    camera.speed = 1000;
    pushCameraMovement(
      component.position -
          Vector2(
            size.x / 2,
            availableSpace / 2,
          ),
    );
  }

  bool isVerticalScreen() {
    return size.y > size.x;
  }

  void overlayPanelFocus(PositionComponent component) {
    if (isVerticalScreen()) {
      bottomSheetFocus(component);
    } else {
      dialogFocus(component);
    }
  }
}
