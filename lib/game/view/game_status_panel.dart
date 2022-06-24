import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/ui/ui.dart';

class GameStatusPanel extends StatelessWidget {
  const GameStatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameBloc>().state;

    return Card(
      child: SizedBox(
        height: 68,
        child: SublightPadding.horizontalMedium(
          child: Row(
            children: [
              const Gap.horizontalMedium(),
              Row(
                children: [
                  const Icon(Icons.people),
                  const Gap.horizontalSmall(),
                  Text(
                    '${gameState.totalPopulation}/${gameState.modifier.peopleCapacity}',
                  ),
                ],
              ),
              const Gap.horizontalMedium(),
            ],
          ),
        ),
      ),
    );
  }
}
