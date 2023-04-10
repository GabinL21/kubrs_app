part of 'timer_bloc.dart';

abstract class TimerEvent {
  const TimerEvent();
}

class TimerStarted extends TimerEvent {
  const TimerStarted();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;
}

class TimerStopped extends TimerEvent {
  const TimerStopped({required this.duration});
  final int duration;
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerDone extends TimerEvent {
  const TimerDone({required this.duration});
  final int duration;
}
