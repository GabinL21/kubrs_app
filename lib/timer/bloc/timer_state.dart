part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState(this.duration);
  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration);
}

class TimerRunning extends TimerState {
  const TimerRunning(super.duration);
}

class TimerComplete extends TimerState {
  const TimerComplete(super.duration);
}

class TimerReseted extends TimerState {
  const TimerReseted() : super(Duration.zero);
}
