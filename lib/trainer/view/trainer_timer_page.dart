import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/gui/bloc/gui_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/session/bloc/session_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/timer/bloc/timer_bloc.dart';
import 'package:kubrs_app/timer/view/timer.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/repository/trainer_solve_repository.dart';
import 'package:kubrs_app/trainer/utils/trainer_scramble_generator.dart';

class TrainerTimerPage extends StatelessWidget {
  const TrainerTimerPage({super.key, required this.algorithmGroup});

  final AlgorithmGroup algorithmGroup;

  @override
  Widget build(BuildContext context) {
    final solveRepository = TrainerSolveRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerBloc(),
        ),
        BlocProvider(
          create: (context) => SolveBloc(solveRepository: solveRepository),
        ),
        BlocProvider(
          create: (context) => SessionBloc(solveRepository: solveRepository),
        ),
        BlocProvider(
          create: (context) => ScrambleBloc(
            scrambleGenerator:
                TrainerScrambleGenerator(algorithmGroup: algorithmGroup),
          ),
        ),
        BlocProvider(
          create: (context) => GuiBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const TrainerTimerView(),
      ),
    );
  }
}

class TrainerTimerView extends StatelessWidget {
  const TrainerTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: Timer(showStats: false),
    );
  }
}
