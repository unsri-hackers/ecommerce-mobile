import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

///Timer Cubit to get Countdown Number
class TimerCubit extends Cubit<TimerState> {
  TimerCubit([int? seconds]) : super(TimerState(seconds!));

  late Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void startTimer(int start) {
    int _start = start;
    emit(TimerState(_start));
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }

        emit(TimerState(_start));
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
