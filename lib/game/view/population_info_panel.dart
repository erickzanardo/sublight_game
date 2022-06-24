import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/ui/ui.dart';

class PopulationInfoPanel extends StatelessWidget {
  const PopulationInfoPanel({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = context.read<GameBloc>();
    return showPanel(
      context: context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: const PopulationInfoPanel(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameBloc>().state;

    final populationEntries = state.population.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return SublightPadding.horizontalMedium(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Population Information',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const Gap.verticalMedium(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Age'),
                Text('Count'),
              ],
            ),
            const Divider(),
            for (var entry in populationEntries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key.toString()),
                  Text(entry.value.toString()),
                ],
              ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Total ${state.totalPopulation}'),
            ),
          ],
        ),
      ),
    );
  }
}
