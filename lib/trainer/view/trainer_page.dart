import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/trainer/bloc/algorithms_bloc.dart';
import 'package:kubrs_app/trainer/bloc/pattern_scramble_bloc.dart';

class TrainerPage extends StatelessWidget {
  const TrainerPage({
    super.key,
    required this.solveRepository,
  });

  final SolveRepository solveRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlgorithmsBloc>(
          create: (context) => AlgorithmsBloc(),
        ),
        BlocProvider<PatternScrambleBloc>(
          create: (context) => PatternScrambleBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const TrainerView(),
      ),
    );
  }
}

class TrainerView extends StatelessWidget {
  const TrainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlgorithmsBloc, AlgorithmsState>(
      builder: (context, state) {
        if (state is! AlgorithmsLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final algorithmGroups = state.algorithmGroups;
        final firstAlgorithm = algorithmGroups.first.algorithms.first;
        return BlocBuilder<PatternScrambleBloc, PatternScrambleState>(
          builder: (context, state) {
            if (state is PatternScrambleInitial) {
              BlocProvider.of<PatternScrambleBloc>(context).add(
                GeneratePatternScrambleEvent(
                  pattern: firstAlgorithm.pattern,
                ),
              );
            }
            if (state is! PatternScrambleLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: Text(state.scramble));
          },
        );
      },
    );
  }
}
