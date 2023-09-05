import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/stats/bloc/stats_bloc.dart';
import 'package:kubrs_app/stats/view/time_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final solveRepository = RepositoryProvider.of<SolveRepository>(context);
    return BlocProvider(
      create: (_) => StatsBloc(solveRepository),
      child: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          return const StatsView();
        },
      ),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsInitial) {
          BlocProvider.of<StatsBloc>(context)
              .add(const LoadLastSolvesStats(100));
        }
        if (state is! StatsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(32),
          child: _getTimeProgressionChart(state.solves, theme),
        );
      },
    );
  }

  Widget _getTimeProgressionChart(List<Solve> solves, ThemeData theme) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: theme.colorScheme.shadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TimeChart(solves: solves));
  }
}
