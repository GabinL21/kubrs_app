import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/gui/bloc/gui_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/scramble/view/scramble_visualization.dart';
import 'package:kubrs_app/session/view/session_chart.dart';
import 'package:kubrs_app/session/view/session_stats.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
import 'package:kubrs_app/timer/view/button/delete_solve_button.dart';
import 'package:kubrs_app/timer/view/button/tag/dnf_tag_toggle_button.dart';
import 'package:kubrs_app/timer/view/button/tag/plus_two_tag_toggle_button.dart';
import 'package:kubrs_app/timer/view/timer_gesture_detector.dart';
import 'package:kubrs_app/timer/view/timer_text.dart';

class Timer extends StatelessWidget {
  const Timer({super.key, this.showStats = true});

  final bool showStats;

  @override
  Widget build(BuildContext context) {
    final timerState = context.select((TimerBloc bloc) => bloc.state);
    final solveState = context.select((SolveBloc bloc) => bloc.state);
    final guiBloc = BlocProvider.of<GuiBloc>(context);
    if (timerState is TimerReset || timerState is TimerRunning) {
      guiBloc.add(HideGui());
    } else {
      guiBloc.add(ShowGui());
    }
    return Column(
      children: [
        _getHeader(context, timerState),
        Expanded(child: _getTimerBody(solveState)),
        _getFooter(timerState),
      ],
    );
  }

  Widget _getHeader(BuildContext context, TimerState timerState) {
    return Column(
      children: [
        if (timerState is! TimerReset && timerState is! TimerRunning)
          _getScrambleHeader(),
      ],
    );
  }

  Widget _getScrambleHeader() {
    return BlocBuilder<ScrambleBloc, ScrambleState>(
      builder: (context, state) {
        return Column(
          children: [
            _getScrambleText(context, state),
            Align(
              alignment: Alignment.centerRight,
              child: _getRefreshScrambleButton(context, state),
            ),
          ],
        );
      },
    );
  }

  Text _getScrambleText(BuildContext context, ScrambleState state) {
    final text = state is ScrambleLoaded
        ? state.scramble
        : '...\n'; // New line to maintain text size
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.secondary),
    );
  }

  Widget _getRefreshScrambleButton(BuildContext context, ScrambleState state) {
    final keyName = state is ScrambleLoaded
        ? 'refreshScrambleButtonShowed'
        : 'refreshScrambleButtonHidden';
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: Visibility(
        key: Key(keyName),
        visible: state is ScrambleLoaded,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: IconButton(
          onPressed: () =>
              context.read<ScrambleBloc>().add(GenerateScrambleEvent()),
          icon: Icon(
            Icons.cached_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
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

  Widget _getSessionChart() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: SizedBox(height: 12, child: SessionChart()),
    );
  }

  Widget _getFooter(TimerState timerState) {
    return Column(
      children: _getFooterChildren(timerState),
    );
  }

  List<Widget> _getFooterChildren(TimerState timerState) {
    if (timerState is TimerReset || timerState is TimerRunning) return [];
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showStats) const SessionStats(),
          const ScrambleVisualization(),
        ],
      ),
      _getSessionChart(),
    ];
  }
}
