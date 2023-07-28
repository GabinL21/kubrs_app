import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';

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
        return _getBody(solves, context);
      },
    );
  }

  Widget _getBody(List<Solve> solves, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: _getSolvesList(solves, context),
      ),
    );
  }

  Widget _getSolvesList(List<Solve> solves, BuildContext context) {
    final nbSolves = solves.length;
    if (nbSolves == 0) return const Text('No solves');
    return ListView.separated(
      itemCount: nbSolves,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: _getSolveTile(solves[index], context),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  Widget _getSolveTile(Solve solve, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                solve.getTimeToDisplay(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                _dateFormat.format(solve.timestamp),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
