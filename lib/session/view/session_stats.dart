import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/session/bloc/session_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/utils/stats_calculator.dart';

class SessionStats extends StatelessWidget {
  const SessionStats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, timerState) {
        final solves = timerState.solves;
        final textStyle = _getTextStyle(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getNumberText(solves, textStyle),
            _getLastAverageText(solves, textStyle),
            _getBestText(solves, textStyle),
          ],
        );
      },
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        );
  }

  Widget _getNumberText(List<Solve> solves, TextStyle? textStyle) {
    final number = solves.length;
    return Text(
      '# Solves: $number',
      style: textStyle,
    );
  }

  Widget _getLastAverageText(List<Solve> solves, TextStyle? textStyle) {
    final averageStat = StatsCalculator.computeAverage(solves, 5);
    final statName = averageStat.getDisplayedName();
    final statValue = averageStat.getDisplayedValue();
    return Text(
      'Last $statName: $statValue',
      style: textStyle,
    );
  }

  Widget _getBestText(List<Solve> solves, TextStyle? textStyle) {
    final bestStat = StatsCalculator.computeBest(solves);
    final statName = bestStat.getDisplayedName();
    final statValue = bestStat.getDisplayedValue();
    return Text(
      '$statName: $statValue',
      style: textStyle,
    );
  }
}
