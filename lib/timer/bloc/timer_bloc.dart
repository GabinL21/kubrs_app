import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(const TimerInitial(Duration.zero)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerStopped>(_onStopped);
    on<TimerReset>(_onReset);
    on<TimerDone>(_onDone);
  }

  Ticker? _ticker;

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(const TimerRunning(Duration.zero));
    _ticker = Ticker(
      (elapsed) => add(TimerTicked(duration: elapsed)),
    )..start();
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunning(event.duration));
  }

  void _onStopped(TimerStopped event, Emitter<TimerState> emit) {
    emit(TimerComplete(event.duration));
    _dispose();
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    emit(const TimerReseted());
    _dispose();
  }

  void _onDone(TimerDone event, Emitter<TimerState> emit) {
    emit(TimerInitial(event.duration));
  }

  void _dispose() {
    _ticker?.dispose();
  }

  @override
  Future<void> close() {
    _dispose();
    return super.close();
  }
}
