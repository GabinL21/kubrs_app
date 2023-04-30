import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/timer/utils/duration_formatter.dart';

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

  static final DateFormat _dateFormat = DateFormat('dd/MM');

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
        final solves = (state as SolveLoaded).solves;
        return _getSolvesTable(solves, context);
      },
    );
  }

  Widget _getSolvesTable(List<Solve> solves, BuildContext context) {
    final tableRows =
        solves.map((solve) => _getSolveRow(solve, context)).toList();
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            children: tableRows,
          ),
        ],
      ),
    );
  }

  TableRow _getSolveRow(Solve solve, BuildContext context) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              _dateFormat.format(solve.timestamp),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              DurationFormatter.format(solve.time),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ],
    );
  }
}
