import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';
import 'package:sublight_game/game/navigation/navigation.dart';
import 'package:sublight_game/ui/ui.dart';

class _SolarSystemSelection extends RectangleComponent {
  _SolarSystemSelection()
      : super.square(
          size: 40,
          position: Vector2(-5, -5),
          paint: Paint()
            ..color = Colors.green
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
}

class _SolarSystemTarget extends RectangleComponent {
  _SolarSystemTarget()
      : super.square(
          size: 40,
          angle: pi / 4,
          anchor: Anchor.center,
          position: Vector2(15, 15),
          paint: Paint()
            ..color = Colors.orange
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
}

class _SolarSystemSelectionBehavior extends Behavior<SolarSystemComponent>
    with
        Tappable,
        FlameBlocReader<NavigationCubit, NavigationState>,
        HasGameRef<SublightGameplay> {
  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    if (bloc.state.selected.value == parent.system) {
      bloc.unselectSolarSystem();
    } else {
      bloc.selectSolarSystem(parent.system);
    }
    return true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      FlameBlocListener<NavigationCubit, NavigationState>(
        listenWhen: (previous, newState) {
          return previous.selected.value == parent.system ||
              newState.selected.value == parent.system;
        },
        onNewState: (state) {
          if (state.selected.value == parent.system) {
            parent.add(_SolarSystemSelection());
            gameRef.overlayPanelFocus(parent);
          } else {
            parent.firstChild<_SolarSystemSelection>()?.removeFromParent();
          }
        },
      ),
    );
  }
}

class _SolarSystemTargetBehavior extends Behavior<SolarSystemComponent>
    with
        FlameBlocReader<NavigationCubit, NavigationState>,
        HasGameRef<SublightGameplay> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      FlameBlocListener<NavigationCubit, NavigationState>(
        listenWhen: (previous, newState) {
          return previous.target.value == parent.system ||
              newState.target.value == parent.system;
        },
        onNewState: (state) {
          if (state.target.value == parent.system) {
            parent.add(_SolarSystemTarget());
          } else {
            parent.firstChild<_SolarSystemTarget>()?.removeFromParent();
          }
        },
      ),
    );
  }
}

class SolarSystemComponent extends Entity {
  SolarSystemComponent({required this.system, super.position})
      : super(
          anchor: Anchor.center,
          size: Vector2.all(30),
          priority: 1,
          children: [
            CircleComponent(
              paint: Paint()..color = Colors.yellow,
              radius: 15,
            ),
          ],
          behaviors: [
            _SolarSystemSelectionBehavior(),
            _SolarSystemTargetBehavior(),
          ],
        );

  final SolarSystem system;
}
