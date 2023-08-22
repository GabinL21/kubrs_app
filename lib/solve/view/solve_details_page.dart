import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsPage extends StatelessWidget {
  const SolveDetailsPage({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SolveDetailsView(solve: solve),
    );
  }
}

class SolveDetailsView extends StatelessWidget {
  SolveDetailsView({super.key, required this.solve});

  final Solve solve;
  final DateFormat dateFormat = DateFormat.yMMMMd().add_jm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 96, 32, 96),
      child: Column(
        children: [
          _getFaceVisualization(),
          _getSolveTime(theme),
          _getSolveDateTime(theme),
          _getScrambleCard(theme),
        ],
      ),
    );
  }

  Widget _getFaceVisualization() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScrambleVisualizer.getUpFace(solve.scramble),
      ],
    );
  }

  Widget _getSolveTime(ThemeData theme) {
    return Text(
      solve.timeToDisplay,
      style: theme.textTheme.displayLarge,
    );
  }

  Widget _getSolveDateTime(ThemeData theme) {
    return Text(
      dateFormat.format(solve.timestamp),
      style: theme.textTheme.displayMedium
          ?.copyWith(color: theme.colorScheme.secondary),
    );
  }

  Widget _getScrambleCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _getScrambleText(theme),
          _getScrambleVisualization(),
        ],
      ),
    );
  }

  Widget _getScrambleText(ThemeData theme) {
    return Text(
      solve.scramble,
      textAlign: TextAlign.center,
      style: theme.textTheme.displaySmall
          ?.copyWith(color: theme.colorScheme.secondary),
    );
  }

  Widget _getScrambleVisualization() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScrambleVisualizer.getCube(solve.scramble),
      ],
    );
  }
}
