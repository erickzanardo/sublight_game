import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:population_repository/population_repository.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';
import 'package:sublight_game/game/navigation/navigation.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final populationRepository = context.read<PopulationRepository>();
            return GameBloc(
              populationRepository: populationRepository,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            // TODO(erickzanardo): just mocking with some random data to test
            return NavigationCubit(
              const NavigationState(
                systems: [
                  SolarSystem(name: 'Alpha', position: Offset(1, 4)),
                  SolarSystem(name: 'Beta', position: Offset(-2, 2)),
                  SolarSystem(name: 'Delta', position: Offset(-2, -4)),
                ],
                target: NavigationValue<Offset>(null),
                selected: NavigationValue<SolarSystem>(null),
              ),
            );
          },
        ),
      ],
      child: const GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final SublightGameplay gameplay;

  @override
  void initState() {
    super.initState();

    final gameBloc = context.read<GameBloc>();
    final navigationCubit = context.read<NavigationCubit>();
    gameplay = SublightGameplay(
      gameBloc: gameBloc,
      navigationCubit: navigationCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: gameplay);
  }
}
