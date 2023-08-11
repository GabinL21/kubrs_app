import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        return BlocBuilder<SolveBloc, SolveState>(
          builder: (context, solveState) {
            return FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _getTimerTextString(timerState, solveState),
                style: _getTimerTextStyle(context),
              ),
            );
          },
        );
      },
    );
  }

  String _getTimerTextString(TimerState timerState, SolveState solveState) {
    if (solveState is! SolveDone) {
      return DurationFormatter.format(timerState.duration);
    }
    final solve = solveState.solve;
    return solve.timeToDisplay;
  }

  TextStyle? _getTimerTextStyle(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge;
    if (context.select((TimerBloc bloc) => bloc.state) is TimerReseted) {
      return textStyle?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: Theme.of(context).textTheme.displayLarge!.fontSize! * 1.10,
      );
    }
    return textStyle;
  }
}
