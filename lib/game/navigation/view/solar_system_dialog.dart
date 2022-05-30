import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/gameplay/gameplay.dart';
import 'package:sublight_game/game/navigation/navigation.dart';
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
          child: Column(
            children: [
              Text(
                system.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
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
