import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final textString = _getTimerTextString(duration);
    final textStyle = _getTimerTextStyle(context);
    return Text(
      textString,
      style: textStyle,
    );
  }

  String _getTimerTextString(Duration duration) {
    final minutesStr = duration.inMinutes.toString();
    final secondsStr =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final millisecondsStr = (duration.inMilliseconds.remainder(1000) / 10)
        .floor()
        .toString()
        .padLeft(2, '0');
    var textStr = '$secondsStr.$millisecondsStr';
    if (duration > const Duration(minutes: 1)) textStr = '$minutesStr:$textStr';
    return textStr;
  }

  TextStyle _getTimerTextStyle(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge!;
    if (context.select((TimerBloc bloc) => bloc.state) is TimerReseted) {
      return textStyle.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: Theme.of(context).textTheme.displayLarge!.fontSize! * 1.10,
      );
    }
    return textStyle;
  }
}
