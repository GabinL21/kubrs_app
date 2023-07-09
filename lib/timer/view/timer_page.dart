import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/gui/bloc/gui_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TimerBloc(),
          ),
          BlocProvider(
            create: (context) => SolveBloc(
              solveRepository: RepositoryProvider.of<SolveRepository>(context),
            ),
          ),
        ],
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
    final guiBloc = BlocProvider.of<GuiBloc>(context);
    if (timerState is! TimerInitial) {
      guiBloc.add(HideGui());
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Expanded(child: _getBody()),
          ],
        ),
      );
    } else {
      guiBloc.add(ShowGui());
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              context.select((ScrambleBloc bloc) => bloc.state.scramble),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            IconButton(
              onPressed: () =>
                  context.read<ScrambleBloc>().add(GenerateScrambleEvent()),
              icon: const Icon(Icons.cached_rounded),
            ),
            Expanded(child: _getBody()),
          ],
        ),
      );
    }
  }

  Widget _getBody() {
    return TimerGestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(child: TimerText()),
        ],
      ),
    );
  }
}
