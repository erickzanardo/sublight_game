import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:population_repository/population_repository.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final populationRepository = context.read<PopulationRepository>();
        return GameBloc(
          populationRepository: populationRepository,
        );
      },
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
    gameplay = SublightGameplay(gameBloc: gameBloc);
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: gameplay);
  }
}
