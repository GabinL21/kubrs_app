import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/trainer/bloc/algorithms_bloc.dart';

class TrainerPage extends StatelessWidget {
  const TrainerPage({
    super.key,
    required this.solveRepository,
  });

  final SolveRepository solveRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlgorithmsBloc(),
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
        return Center(
          child: Text(firstAlgorithm.name),
        );
      },
    );
  }
}
