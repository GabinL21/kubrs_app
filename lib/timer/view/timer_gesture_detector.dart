import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

class TimerGestureDetector extends StatelessWidget {
  const TimerGestureDetector({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<TimerBloc>(context).state;
    return GestureDetector(
      onLongPressStart: (_) => _resetTimer(state, context),
      onLongPressEnd: (_) => _startTimer(state, context),
      onPanDown: (_) => _stopTimer(state, context),
      onTapUp: (_) => _endTimer(state, context),
      onPanEnd: (_) => _endTimer(state, context),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        child: child,
      ),
    );
  }

  void _resetTimer(TimerState state, BuildContext context) {
    if (state is! TimerInitial && state is! TimerDone) return;
    context.read<TimerBloc>().add(const ResetTimer());
    context.read<SolveBloc>().add(const ResetSolve());
  }

  void _startTimer(TimerState state, BuildContext context) {
    if (state is TimerStopped) _endTimer(state, context);
    if (state is! TimerReset) return;
    context.read<TimerBloc>().add(const StartTimer());
  }

  void _stopTimer(TimerState state, BuildContext context) {
    if (state is! TimerRunning) return;
    context.read<TimerBloc>().add(StopTimer(duration: state.duration));
    final scramble = context.read<ScrambleBloc>().state.scramble;
    final solve = Solve.createNow(
      time: state.duration,
      scramble: scramble,
    );
    context.read<SolveBloc>().add(EndSolve(solve: solve));
    context.read<ScrambleBloc>().add(GenerateScrambleEvent());
  }

  void _endTimer(TimerState state, BuildContext context) {
    if (state is! TimerStopped) return;
    context.read<TimerBloc>().add(EndTimer(duration: state.duration));
  }
}
