import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => SolveRepository(),
      child: BlocProvider(
        create: (context) => SolveBloc(
          solveRepository: RepositoryProvider.of<SolveRepository>(context),
        ),
        child: const HistoryView(),
      ),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SolveBloc>().add(GetSolves());
    return BlocBuilder<SolveBloc, SolveState>(
      builder: (_, state) {
        if (state is SolveInitial || state is SolveLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Text((state as SolveLoaded).solves.first.scramble);
      },
    );
  }
}
