import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';

class Timeflow extends Component with HasGameRef<SublightGameplay> {
  Timeflow({required this.timeBar});

  final Timebar timeBar;

  double value = 0;

  @override
  void update(double dt) {
    value += dt * gameRef.timeflowCubit.state.speed.value;
    if (value >= 365) {
      value -= 365;
      gameRef.gameBloc.add(YearPassed());
    }
    timeBar.size.x = value / 365 * gameRef.size.x;
  }
}

class Timebar extends PositionComponent with HasPaint {
  Timebar() {
    positionType = PositionType.widget;
    height = 16;
    paint = Paint()..color = Colors.blue;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), paint);
  }
}
