part of 'timer_bloc.dart';

abstract class TimerEvent {
  const TimerEvent();
}

class ResetTimer extends TimerEvent {
  const ResetTimer();
}

class StartTimer extends TimerEvent {
  const StartTimer();
}

class TickTimer extends TimerEvent {
  const TickTimer({required this.duration});
  final Duration duration;
}

class StopTimer extends TimerEvent {
  const StopTimer({required this.duration});
  final Duration duration;
}

class EndTimer extends TimerEvent {
  const EndTimer({required this.duration});
  final Duration duration;
}
