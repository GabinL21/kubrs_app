import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/view/solve_details_delete_button.dart';

class SolveDetailsPage extends StatelessWidget {
  const SolveDetailsPage({
    super.key,
    required this.solve,
    required this.solveBloc,
  });

  final Solve solve;
  final SolveBloc solveBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: solveBloc,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SolveDetailsView(solve: solve),
      ),
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
      padding: const EdgeInsets.fromLTRB(48, 64, 48, 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getHeader(theme),
          _getScrambleCard(theme),
          _getActions(theme),
        ],
      ),
    );
  }

  Widget _getHeader(ThemeData theme) {
    return Column(
      children: [
        _getFaceVisualization(),
        const SizedBox(height: 48),
        _getSolveTime(theme),
        const SizedBox(height: 8),
        _getSolveDateTime(theme),
      ],
    );
  }

  Widget _getFaceVisualization() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScrambleVisualizer.getUpFace(scramble: solve.scramble, size: 24),
      ],
    );
  }

  Widget _getSolveTime(ThemeData theme) {
    return Text(
      solve.timeToDisplay,
      style: theme.textTheme.displayLarge?.copyWith(fontSize: 56),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _getScrambleText(theme),
          const SizedBox(height: 16),
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
        ScrambleVisualizer.getCube(scramble: solve.scramble),
      ],
    );
  }

  Widget _getActions(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getEditButton(theme),
        const SizedBox(width: 32),
        SolveDetailsDeleteButton(solve: solve),
      ],
    );
  }

  Widget _getEditButton(ThemeData theme) {
    return IconButton(
      onPressed: () => {},
      icon: Icon(Icons.edit_outlined, color: theme.colorScheme.primary),
    );
  }
}
