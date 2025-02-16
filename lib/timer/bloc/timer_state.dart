part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState(this.duration);
  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial() : super(Duration.zero);
}

class TimerReset extends TimerState {
  const TimerReset() : super(Duration.zero);
}

class TimerRunning extends TimerState {
  const TimerRunning(super.duration);
}

class TimerStopped extends TimerState {
  const TimerStopped(super.duration);
}

class TimerDone extends TimerState {
  const TimerDone(super.duration);
}
