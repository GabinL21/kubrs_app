import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(const TimerInitial(0)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerStopped>(_onStopped);
    on<TimerReset>(_onReset);
    on<TimerDone>(_onDone);
  }

  late Ticker _ticker;

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(const TimerRunning(0));
    _ticker = Ticker((elapsed) {
      final duration = elapsed.inMilliseconds;
      add(TimerTicked(duration: duration));
    });
    _ticker.start();
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunning(event.duration));
  }

  void _onStopped(TimerStopped event, Emitter<TimerState> emit) {
    emit(TimerComplete(event.duration));
    _ticker.dispose();
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    emit(const TimerReseted());
    _ticker.dispose();
  }

  void _onDone(TimerDone event, Emitter<TimerState> emit) {
    emit(TimerInitial(event.duration));
  }

  @override
  Future<void> close() {
    _ticker.dispose();
    return super.close();
  }
}
