import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:population_repository/population_repository.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';
import 'package:sublight_game/game/navigation/navigation.dart';
import 'package:sublight_game/game/timeflow/timeflow.dart';

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
              state: GameState(
                position: Offset.zero,
                population: const {},
                moving: false,
                rooms: {
                  Offset.zero: const ShipRoom(module: ShipModule.bridge),
                  const Offset(0, 1): const ShipRoom(
                    module: ShipModule.sblDriver,
                  ),
                },
              ),
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
                target: NavigationValue<SolarSystem>(null),
                selected: NavigationValue<SolarSystem>(null),
              ),
            );
          },
        ),
        BlocProvider(create: (_) => TimeflowCubit()),
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
    final timeflowCubit = context.read<TimeflowCubit>();
    gameplay = SublightGameplay(
      gameBloc: gameBloc,
      navigationCubit: navigationCubit,
      timeflowCubit: timeflowCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        SolarSystemDialogListener(gameplay: gameplay),
      ],
      child: GameWidget<SublightGameplay>(
        game: gameplay,
        initialActiveOverlays: const [SublightGameplay.timeflowPanel],
        overlayBuilderMap: {
          SublightGameplay.engageOverlay: (context, game) {
            return Positioned(
              top: 16,
              right: 16,
              child: ElevatedButton(
                child: const Text('Engage'),
                onPressed: () {
                  game.gameBloc.add(DriveEngaged());
                },
              ),
            );
          },
          SublightGameplay.timeflowPanel: (context, game) {
            return const Positioned(
              bottom: 16,
              left: 16,
              child: TimeControlePanel(),
            );
          },
        },
      ),
    );
  }
}
