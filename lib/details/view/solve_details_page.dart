import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/details/cubit/solve_details_cubit.dart';
import 'package:kubrs_app/details/view/solve_details_delete_button.dart';
import 'package:kubrs_app/details/view/solve_details_edit_button.dart';
import 'package:kubrs_app/details/view/solve_details_share_button.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsPage extends StatelessWidget {
  const SolveDetailsPage({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SolveDetailsCubit(solve),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: const [SolveDetailsShareButton()],
        ),
        body: SolveDetailsView(),
      ),
    );
  }
}

class SolveDetailsView extends StatelessWidget {
  SolveDetailsView({super.key});

  final DateFormat dateFormat = DateFormat.yMMMMd().add_jm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolveDetailsCubit, Solve>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.fromLTRB(48, 64, 48, 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getHeader(state, theme),
              _getScrambleCard(state, theme),
              _getActions(theme),
            ],
          ),
        );
      },
    );
  }

  Widget _getHeader(Solve solve, ThemeData theme) {
    return Column(
      children: [
        _getFaceVisualization(solve),
        const SizedBox(height: 48),
        _getSolveTime(solve, theme),
        const SizedBox(height: 8),
        _getSolveDateTime(solve, theme),
      ],
    );
  }

  Widget _getFaceVisualization(Solve solve) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScrambleVisualizer
            .fromScramble(scramble: solve.scramble, size: 24)
            .getUpFace(),
      ],
    );
  }

  Widget _getSolveTime(Solve solve, ThemeData theme) {
    return Text(
      solve.timeToDisplay,
      style: theme.textTheme.displayLarge?.copyWith(fontSize: 56),
    );
  }

  Widget _getSolveDateTime(Solve solve, ThemeData theme) {
    return Text(
      dateFormat.format(solve.timestamp),
      style: theme.textTheme.displayMedium
          ?.copyWith(color: theme.colorScheme.secondary),
    );
  }

  Widget _getScrambleCard(Solve solve, ThemeData theme) {
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
          _getScrambleText(solve, theme),
          const SizedBox(height: 16),
          _getScrambleVisualization(solve),
        ],
      ),
    );
  }

  Widget _getScrambleText(Solve solve, ThemeData theme) {
    return Text(
      solve.scramble,
      textAlign: TextAlign.center,
      style: theme.textTheme.displaySmall
          ?.copyWith(color: theme.colorScheme.secondary),
    );
  }

  Widget _getScrambleVisualization(Solve solve) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScrambleVisualizer.fromScramble(scramble: solve.scramble).getCube(),
      ],
    );
  }

  Widget _getActions(ThemeData theme) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SolveDetailsEditButton(),
        SizedBox(width: 32),
        SolveDetailsDeleteButton(),
      ],
    );
  }
}
