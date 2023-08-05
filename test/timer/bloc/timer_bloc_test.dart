import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

void main() {
  group('TimerBloc', () {
    blocTest<TimerBloc, TimerState>(
      'emits initial state when timer is created',
      build: TimerBloc.new,
      verify: (bloc) => bloc.state == const TimerInitial(),
    );

    blocTest<TimerBloc, TimerState>(
      'emits reset state when timer is reseted',
      build: TimerBloc.new,
      act: (bloc) => bloc.add(const ResetTimer()),
      expect: () => const <TimerState>[TimerReseted()],
    );

    blocTest<TimerBloc, TimerState>(
      'emits running state when timer is started',
      setUp: WidgetsFlutterBinding.ensureInitialized,
      build: TimerBloc.new,
      seed: TimerReseted.new,
      act: (bloc) => bloc.add(const StartTimer()),
      expect: () => const <TimerState>[TimerRunning(Duration.zero)],
    );

    blocTest<TimerBloc, TimerState>(
      'emits running states when timer ticks',
      build: TimerBloc.new,
      seed: () => const TimerRunning(Duration.zero),
      act: (bloc) => bloc
        ..add(const TickTimer(duration: Duration(seconds: 1)))
        ..add(const TickTimer(duration: Duration(seconds: 2))),
      expect: () => const <TimerState>[
        TimerRunning(Duration(seconds: 1)),
        TimerRunning(Duration(seconds: 2)),
      ],
    );

    blocTest<TimerBloc, TimerState>(
      'emits stop state when timer is stopped',
      build: TimerBloc.new,
      seed: () => const TimerRunning(Duration(seconds: 10)),
      act: (bloc) => bloc.add(const StopTimer(duration: Duration(seconds: 10))),
      expect: () => const <TimerState>[TimerStopped(Duration(seconds: 10))],
    );

    blocTest<TimerBloc, TimerState>(
      'emits done state when timer is ended',
      build: TimerBloc.new,
      seed: () => const TimerStopped(Duration(seconds: 10)),
      act: (bloc) => bloc.add(const EndTimer(duration: Duration(seconds: 10))),
      expect: () => const <TimerState>[TimerDone(Duration(seconds: 10))],
    );
  });
}
