import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';

class _SpaceshipMoviment extends Behavior<SpaceshipComponent>
    with HasGameRef<SublightGameplay> {
  _SpaceshipMoviment({
    required this.target,
    required this.currentPosition,
    required this.onArrive,
    required this.onPositionUpdated,
  });

  final Offset target;
  final Offset currentPosition;
  final VoidCallback onArrive;
  final void Function(Offset) onPositionUpdated;

  late final Vector2 _direction;
  late final double _speed;
  Offset? _lastMapOffset;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final gameState = gameRef.gameBloc.state;

    _direction = (target - gameState.position).toVector2().normalized();

    parent.angle = atan2(_direction.y, _direction.x);

    _speed = gameState.modifier.sblSpeed;

    ScaleEffect getEngineEffect() {
      return ScaleEffect.to(
        Vector2.all(0.8),
        InfiniteEffectController(
          SequenceEffectController(
            [
              CurvedEffectController(4, Curves.easeInOut),
              ReverseCurvedEffectController(4, Curves.easeInOut),
            ],
          ),
        ),
      );
    }

    await addAll(
      [
        TimerComponent(
          period: 2,
          repeat: true,
          onTick: () {
            if (_lastMapOffset != null) {
              onPositionUpdated(_lastMapOffset!);
            }
          },
        ),
        CircleComponent(
          anchor: Anchor.center,
          radius: 6,
          position: Vector2(0, 5),
          paint: Paint()..color = Colors.yellow,
          children: [
            getEngineEffect(),
          ],
        ),
        CircleComponent(
          anchor: Anchor.center,
          radius: 4,
          position: Vector2(0, 5),
          paint: Paint()..color = Colors.orange,
          children: [
            getEngineEffect(),
          ],
        ),
      ],
    );
  }

  @override
  void update(double dt) {
    final timeflowDt = dt * gameRef.timeflowCubit.state.speed.value;
    final value = timeflowDt * SublightGameplay.lightYearsRatio / 365;

    parent.position += _direction * value * _speed;

    final currentMapPosition =
        (parent.position / SublightGameplay.lightYearsRatio).clone();

    _lastMapOffset = Offset(
      currentMapPosition.x.truncateToDouble(),
      currentMapPosition.y.truncateToDouble(),
    );

    if (_lastMapOffset == target) {
      removeFromParent();
      onArrive();
    }
  }
}

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
            parent.add(
              _SpaceshipMoviment(
                target: target.position,
                currentPosition: state.position,
                onArrive: () {
                  gameRef.navigationCubit.removeTarget();
                  gameRef.gameBloc.add(
                    DriveDisengaged(target.position),
                  );
                },
                onPositionUpdated: (position) {
                  gameRef.gameBloc.add(PositionReported(position));
                },
              ),
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
          size: Vector2(25, 20),
          priority: 2,
          children: [
            PolygonComponent(
              [
                Vector2(15, 0),
                Vector2(-15, 10),
                Vector2(-15, -10),
                Vector2(15, 0),
              ],
              position: Vector2(12.5, 5),
              anchor: Anchor.center,
              paint: Paint()..color = Colors.greenAccent,
              size: Vector2(25, 20),
              priority: 2,
            ),
          ],
          behaviors: [
            _SpaceshipTargetBehavior(),
          ],
        );
}
