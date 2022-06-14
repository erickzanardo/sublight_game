import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sublight_game/game/extensions/extensions.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';
import 'package:sublight_game/game/navigation/navigation.dart';
import 'package:sublight_game/game/navigation/view/solar_system_dialog/solar_system_icon.dart';
import 'package:sublight_game/ui/ui.dart';

class SolarSystemDialogListener
    extends BlocListener<NavigationCubit, NavigationState> {
  SolarSystemDialogListener({
    super.key,
    required SublightGameplay gameplay,
  }) : super(
          listenWhen: (previous, current) {
            return previous.selected.value != current.selected.value;
          },
          listener: (context, state) {
            if (state.selected.value != null) {
              final navigationCubit = context.read<NavigationCubit>();
              final gameBloc = context.read<GameBloc>();
              showOverlayPanel<void>(
                context: context,
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: navigationCubit),
                      BlocProvider.value(value: gameBloc),
                    ],
                    child: SolarSystemPanel(system: state.selected.value!),
                  );
                },
              ).whenComplete(() {
                gameplay.popCameraMovement();
              });
            }
          },
        );
}

class SolarSystemPanel extends StatelessWidget {
  const SolarSystemPanel({
    super.key,
    required this.system,
  });

  final SolarSystem system;

  @override
  Widget build(BuildContext context) {
    final isShipMoving = context.watch<GameBloc>().state.moving;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  system.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Gap.verticalBig(),
                SolarSystemIcon(star: system.star),
                const Gap.verticalBig(),
                Text(
                  '${system.star.starClass} star class system',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const Gap.verticalSmall(),
                Text(system.star.description),
              ],
            ),
          ),
        ),
        const Gap.verticalSmall(),
        if (!isShipMoving) ...[
          ElevatedButton(
            onPressed: () {
              context.read<NavigationCubit>().setTarget(system);
              Navigator.of(context).pop();
            },
            child: const Text('Set destination'),
          ),
          const Gap.verticalSmall(),
        ],
        ElevatedButton(
          onPressed: () {
            context.read<NavigationCubit>().unselectSolarSystem();
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        const Gap.verticalMedium(),
      ],
    );
  }
}
