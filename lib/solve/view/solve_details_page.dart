import 'package:flutter/material.dart';
import 'package:kubrs_app/history/utils/date_time_formatter.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/scramble/view/scramble_visualization.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsPage extends StatelessWidget {
  const SolveDetailsPage({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SolveDetailsView(solve: solve),
    );
  }
}

class SolveDetailsView extends StatelessWidget {
  const SolveDetailsView({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 96, 32, 96),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _getScrambleVisualization(),
              _getSolveTime(theme),
              _getSolveDateTime(theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getScrambleVisualization() {
    return ScrambleVisualizer.getUpFace(solve.scramble);
  }

  Widget _getSolveTime(ThemeData theme) {
    return Text(
      solve.timeToDisplay,
      style: theme.textTheme.displayLarge,
    );
  }

  Widget _getSolveDateTime(ThemeData theme) {
    return Text(
      DateTimeFormatter.format(solve.timestamp),
      style: theme.textTheme.displayMedium
          ?.copyWith(color: theme.colorScheme.secondary),
    );
  }
}
