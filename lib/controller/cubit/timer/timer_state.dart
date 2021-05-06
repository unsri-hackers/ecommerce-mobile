part of 'timer_cubit.dart';

 class TimerState extends Equatable {
  final int seconds;
  const TimerState(this.seconds);

  @override
  List<Object> get props => [seconds];

}
