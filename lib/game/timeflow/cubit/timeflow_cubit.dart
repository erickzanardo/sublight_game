import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timeflow_state.dart';

class TimeflowCubit extends Cubit<TimeflowState> {
  TimeflowCubit()
      : super(
          const TimeflowState(speed: TimeSpeed.normal),
        );

  void setSpeed(TimeSpeed speed) {
    emit(state.copyWith(speed: speed));
  }
}
