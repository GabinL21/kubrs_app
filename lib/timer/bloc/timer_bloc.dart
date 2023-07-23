import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(const TimerInitial()) {
    on<ResetTimer>(_onReset);
    on<StartTimer>(_onStart);
    on<TickTimer>(_onTick);
    on<StopTimer>(_onStop);
    on<EndTimer>(_onEnd);
  }

  Ticker? _ticker;

  void _onReset(ResetTimer event, Emitter<TimerState> emit) {
    emit(const TimerReseted());
    _dispose();
  }

  void _onStart(StartTimer event, Emitter<TimerState> emit) {
    emit(const TimerRunning(Duration.zero));
    _ticker = Ticker(
      (elapsed) => add(TickTimer(duration: elapsed)),
    )..start();
  }

  void _onTick(TickTimer event, Emitter<TimerState> emit) {
    emit(TimerRunning(event.duration));
  }

  void _onStop(StopTimer event, Emitter<TimerState> emit) {
    emit(TimerStopped(event.duration));
    _dispose();
  }

  void _onEnd(EndTimer event, Emitter<TimerState> emit) {
    emit(TimerDone(event.duration));
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
