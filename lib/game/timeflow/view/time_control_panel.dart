import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/game/timeflow/timeflow.dart';

class TimeControlePanel extends StatelessWidget {
  const TimeControlePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final speed = context.select((TimeflowCubit cubit) => cubit.state.speed);
    final year = context.select((GameBloc bloc) => bloc.state.year);

    return Card(
      child: SizedBox(
        width: 160,
        height: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Year: $year'),
            Row(
              children: [
                TimeSpeedIcon(
                  speed: TimeSpeed.paused,
                  current: speed,
                  icon: Icons.pause,
                ),
                TimeSpeedIcon(
                  speed: TimeSpeed.normal,
                  current: speed,
                  icon: Icons.play_arrow,
                ),
                TimeSpeedIcon(
                  speed: TimeSpeed.fast,
                  current: speed,
                  icon: Icons.fast_forward,
                ),
                TimeSpeedIcon(
                  speed: TimeSpeed.superFast,
                  current: speed,
                  icon: Icons.bolt,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSpeedIcon extends StatelessWidget {
  const TimeSpeedIcon({
    super.key,
    required this.speed,
    required this.current,
    required this.icon,
  });

  final TimeSpeed speed;
  final TimeSpeed current;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: current == speed
          ? null
          : () {
              context.read<TimeflowCubit>().setSpeed(speed);
            },
      icon: Icon(icon),
    );
  }
}
