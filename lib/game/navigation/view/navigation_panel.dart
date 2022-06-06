import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/navigation/navigation.dart';
import 'package:sublight_game/ui/ui.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.watch<GameBloc>();
    final navigationState = context.watch<NavigationCubit>().state;

    final target = navigationState.target.value?.position ?? Offset.zero;
    final distance = (target - gameBloc.state.position).toVector2().normalize();

    final currentX = gameBloc.state.position.dx.toInt();
    final currentY = gameBloc.state.position.dy.toInt();

    return Card(
      child: SizedBox(
        width: 150,
        height: 120,
        child: Column(
          children: [
            const Gap.verticalSmall(),
            Text('Destination: ${navigationState.target.value?.name}'),
            const Gap.verticalSmall(),
            Text('Current position: $currentX - $currentY'),
            const Gap.verticalSmall(),
            Text('Distance: ${distance.toStringAsFixed(2)}'),
            const Gap.verticalSmall(),
            if (!gameBloc.state.moving)
              ElevatedButton(
                child: const Text('Engage'),
                onPressed: () {
                  gameBloc.add(DriveEngaged());
                },
              ),
          ],
        ),
      ),
    );
  }
}
