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

    _speed = gameState.modifier.sblSpeed;

    await add(
      TimerComponent(
        period: 2,
        repeat: true,
        onTick: () {
          if (_lastMapOffset != null) {
            onPositionUpdated(_lastMapOffset!);
          }
        },
      ),
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
          size: Vector2.all(10),
          priority: 2,
          children: [
            PolygonComponent(
              [
                Vector2(0, 20),
                Vector2(15, 0),
                Vector2(-15, 0),
                Vector2(0, 20),
              ],
              paint: Paint()..color = Colors.greenAccent,
              size: Vector2(25, 25),
              anchor: Anchor.center,
              //position: Vector2.all(-12),
              children: [
                SequenceEffect(
                  [
                    ScaleEffect.to(
                      Vector2(-1, 1),
                      EffectController(
                        duration: 4,
                      ),
                    ),
                    ScaleEffect.to(
                      Vector2(1, 1),
                      EffectController(
                        duration: 4,
                      ),
                    ),
                  ],
                  infinite: true,
                ),
              ],
            ),
          ],
          behaviors: [
            _SpaceshipTargetBehavior(),
          ],
        );
}
