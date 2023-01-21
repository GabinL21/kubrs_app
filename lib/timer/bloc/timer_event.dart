part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {
  const TimerEvent();
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});
  final int duration;
}
