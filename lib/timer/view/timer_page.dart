import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/gui/bloc/gui_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
import 'package:kubrs_app/timer/view/tags/dnf_tag_toggle_button.dart';
import 'package:kubrs_app/timer/view/tags/plus_two_tag_toggle_button.dart';
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
          if (timerState is! TimerReseted && timerState is! TimerRunning)
            BlocBuilder<ScrambleBloc, ScrambleState>(
              builder: (context, state) {
                return Text(
                  state.scramble,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            ),
          if (timerState is! TimerReseted && timerState is! TimerRunning)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () =>
                    context.read<ScrambleBloc>().add(GenerateScrambleEvent()),
                icon: Icon(
                  Icons.cached_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          Expanded(child: _getTimerBody(solveState)),
        ],
      ),
    );
  }

  Widget _getTimerBody(SolveState solveState) {
    return TimerGestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(child: TimerText()),
          if (solveState is SolveDone)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PlusTwoTagToggleButton(),
                  DNFTagToggleButton(),
                ],
              ),
            )
        ],
      ),
    );
  }
}
