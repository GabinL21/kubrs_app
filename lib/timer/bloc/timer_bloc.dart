import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/timer/utils/ticker.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial()) {
    on<TimerStarted>(_onStarted);
    on<_TimerTicked>(_onTicked);
  }

  final Ticker _ticker;
  
  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(const TimerRunning(0));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick()
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunning(event.duration));
  }
}
