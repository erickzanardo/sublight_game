import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/navigation/navigation.dart';

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

class _SolarSystemTapBehavior extends Behavior<SolarSystemComponent>
    with Tappable, FlameBlocReader<NavigationCubit, NavigationState> {
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
          } else {
            parent.firstChild<_SolarSystemSelection>()?.removeFromParent();
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
          children: [
            CircleComponent(
              paint: Paint()..color = Colors.yellow,
              radius: 15,
            ),
          ],
          behaviors: [
            _SolarSystemTapBehavior(),
          ],
        );

  final SolarSystem system;
}
