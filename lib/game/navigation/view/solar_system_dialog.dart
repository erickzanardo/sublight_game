import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              showOverlayPanel<void>(
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: navigationCubit,
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
