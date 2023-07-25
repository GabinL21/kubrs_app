import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/timer/utils/duration_formatter.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => HistoryRepository(),
      child: BlocProvider(
        create: (context) => HistoryBloc(
          historyRepository: RepositoryProvider.of<HistoryRepository>(context),
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
    context.read<HistoryBloc>().add(const GetHistory());
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (_, state) {
        if (state is HistoryInitial || state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final solves = state.solves;
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
              DurationFormatter.format(solve.getEffectiveTime()),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ],
    );
  }
}
