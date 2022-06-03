part of 'timeflow_cubit.dart';

enum TimeSpeed {
  paused(0),
  normal(1),
  fast(25),
  superFast(100);

  const TimeSpeed(this.value);

  final double value;
}

class TimeflowState extends Equatable {
  const TimeflowState({required this.speed});

  final TimeSpeed speed;

  TimeflowState copyWith({TimeSpeed? speed}) {
    return TimeflowState(
      speed: speed ?? this.speed,
    );
  }

  @override
  List<Object?> get props => [speed];
}
