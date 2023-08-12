import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/gui/bloc/gui_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:kubrs_app/session/view/session_stats.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
import 'package:kubrs_app/timer/view/button/delete_solve_button.dart';
import 'package:kubrs_app/timer/view/button/tag/dnf_tag_toggle_button.dart';
import 'package:kubrs_app/timer/view/button/tag/plus_two_tag_toggle_button.dart';
import 'package:kubrs_app/timer/view/timer_gesture_detector.dart';
import 'package:kubrs_app/timer/view/timer_text.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserInitial) userBloc.add(UserRequested());
    return RepositoryProvider(
      create: (_) => SolveRepository(),
      child: BlocProvider(
        create: (_) => TimerBloc(),
        child: const TimerView(),
      ),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final timerState = context.select((TimerBloc bloc) => bloc.state);
    final solveState = context.select((SolveBloc bloc) => bloc.state);
    final guiBloc = BlocProvider.of<GuiBloc>(context);
    if (timerState is TimerReseted || timerState is TimerRunning) {
      guiBloc.add(HideGui());
    } else {
      guiBloc.add(ShowGui());
    }
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _getHeader(context, timerState),
          Expanded(child: _getTimerBody(solveState)),
          _getFooter(timerState),
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context, TimerState timerState) {
    return Column(
      children: [
        if (timerState is! TimerReseted && timerState is! TimerRunning)
          _getScrambleText(),
        if (timerState is! TimerReseted && timerState is! TimerRunning)
          Align(
            alignment: Alignment.centerRight,
            child: _getRefreshScrambleButton(context),
          ),
      ],
    );
  }

  Widget _getScrambleText() {
    return BlocBuilder<ScrambleBloc, ScrambleState>(
      builder: (context, state) {
        return Text(
          state.scramble,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        );
      },
    );
  }

  Widget _getRefreshScrambleButton(BuildContext context) {
    return IconButton(
      onPressed: () =>
          context.read<ScrambleBloc>().add(GenerateScrambleEvent()),
      icon: Icon(
        Icons.cached_rounded,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _getTimerBody(SolveState solveState) {
    return TimerGestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(child: TimerText()),
          if (solveState is SolveDone) _getActionButtons(),
        ],
      ),
    );
  }

  Widget _getActionButtons() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DeleteSolveButton(),
          PlusTwoTagToggleButton(),
          DNFTagToggleButton(),
        ],
      ),
    );
  }

  Widget _getFooter(TimerState timerState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (timerState is! TimerReseted && timerState is! TimerRunning)
          const SessionStats(),
        if (timerState is! TimerReseted && timerState is! TimerRunning)
          _getScrambleVisualization(),
      ],
    );
  }

  Widget _getScrambleVisualization() {
    return BlocBuilder<ScrambleBloc, ScrambleState>(
      builder: (context, state) {
        if (state is ScrambleLoading) {
          return ScrambleVisualizer.getLoadingCubeVisualization();
        }
        return ScrambleVisualizer.getCubeVisualization(state.scramble);
      },
    );
  }
}
