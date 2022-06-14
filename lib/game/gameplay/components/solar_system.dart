import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_stellaris/flame_stellaris.dart';
import 'package:flutter/material.dart';
import 'package:solar_system_repository/solar_system_repository.dart';
import 'package:sublight_game/game/extensions/extensions.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';
import 'package:sublight_game/game/navigation/navigation.dart';
import 'package:sublight_game/ui/ui.dart';

class _SolarSystemSelection extends PositionComponent
    with ParentIsA<PositionComponent> {
  _SolarSystemSelection() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await add(
      RectangleComponent.square(
        size: parent.size.x + 10,
        position: Vector2.all(-5),
        paint: Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );
  }
}

class _SolarSystemTarget extends PositionComponent
    with ParentIsA<PositionComponent> {
  _SolarSystemTarget()
      : super(
          anchor: Anchor.center,
          angle: pi / 4,
        );

  @override
  Future<void> onLoad() async {
    position = parent.size / 2;
    await add(
      RectangleComponent.square(
        size: parent.size.x + 10,
        anchor: Anchor.center,
        paint: Paint()
          ..color = Colors.orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );
  }
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
          return previous.target.value != newState.target.value;
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

class _SolarSystemStar extends PositionComponent
    with ParentIsA<PositionComponent> {
  _SolarSystemStar(this.star);

  final Star star;

  @override
  Future<void> onLoad() async {
    size = parent.size;
    const flameStellaris = FlatStellarisGenerator();
    await add(
      flameStellaris.generateStar(
        StarData(
          position: size / 2,
          size: star.size,
          color: star.palette,
        ),
      ),
    );
  }
}

class SolarSystemComponent extends Entity {
  SolarSystemComponent({required this.system, super.position})
      : super(
          anchor: Anchor.center,
          size: Vector2.all(system.star.size),
          priority: 1,
          children: [
            _SolarSystemStar(system.star),
          ],
          behaviors: [
            _SolarSystemSelectionBehavior(),
            _SolarSystemTargetBehavior(),
          ],
        );

  final SolarSystem system;
}
