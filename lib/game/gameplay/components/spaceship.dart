import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';

class _SpaceshipTargetBehavior extends Behavior<SpaceshipComponent>
    with HasGameRef<SublightGameplay> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      FlameBlocListener<GameBloc, GameState>(
        listenWhen: (previous, state) => previous.moving != state.moving,
        onNewState: (state) {
          final target = gameRef.navigationCubit.state.target.value;
          if (target != null) {
            final distance = (state.position - target.position).toVector2();

            final sublightSpeed = state.modifier.sblSpeed;
            final travelTime = distance.length / sublightSpeed;

            parent.add(
              MoveEffect.to(
                target.position.toVector2() * SublightGameplay.lightYearsRatio,
                EffectController(duration: travelTime),
              )..onFinishCallback = () {
                  gameRef.navigationCubit.removeTarget();
                  gameRef.gameBloc.add(
                    DriveDisengaged(target.position),
                  );
                },
            );
          }
        },
      ),
    );
  }
}

class SpaceshipComponent extends Entity {
  SpaceshipComponent({super.position})
      : super(
          anchor: Anchor.center,
          size: Vector2.all(10),
          priority: 2,
          children: [
            CircleComponent(
              paint: Paint()..color = Colors.blue,
              radius: 5,
            ),
          ],
          behaviors: [
            _SpaceshipTargetBehavior(),
          ],
        );
}
