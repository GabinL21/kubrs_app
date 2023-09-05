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
      builder: (context, state) {
        final solves = state.solves;
        final textStyle = _getTextStyle(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getSolveCountStatText(solves, textStyle),
            _getBestSolveText(solves, textStyle),
            _getSolveMeanText(solves, textStyle),
            _getLastAverageText(solves, textStyle),
            _getBestAverageText(solves, textStyle),
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

  Widget _getSolveCountStatText(List<Solve> solves, TextStyle? textStyle) {
    final count = solves.length;
    return Text(
      'Count: $count',
      style: textStyle,
    );
  }

  Widget _getBestSolveText(List<Solve> solves, TextStyle? textStyle) {
    final bestStat = StatsCalculator.computeBest(solves);
    final statName = bestStat.displayedName;
    final statValue = bestStat.displayedValue;
    return Text(
      '$statName: $statValue',
      style: textStyle,
    );
  }

  Widget _getSolveMeanText(List<Solve> solves, TextStyle? textStyle) {
    final meanStat = StatsCalculator.computeMean(solves);
    final statValue = meanStat.displayedValue;
    return Text(
      'Mean: $statValue',
      style: textStyle,
    );
  }

  Widget _getLastAverageText(List<Solve> solves, TextStyle? textStyle) {
    final averageStat = StatsCalculator.computeAverage(solves, 5);
    final statName = averageStat.displayedName;
    final statValue = averageStat.displayedValue;
    return Text(
      'Last $statName: $statValue',
      style: textStyle,
    );
  }

  Widget _getBestAverageText(List<Solve> solves, TextStyle? textStyle) {
    final averageStat = StatsCalculator.computeBestAverage(solves, 5);
    final statName = averageStat.displayedName;
    final statValue = averageStat.displayedValue;
    return Text(
      'Best $statName: $statValue',
      style: textStyle,
    );
  }
}
