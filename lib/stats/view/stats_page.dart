import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/stats/bloc/stats_bloc.dart';

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
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsInitial) {
          BlocProvider.of<StatsBloc>(context)
              .add(LoadLastSevenDaysSolvesStats());
        }
        if (state is! StatsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final solves = state.solves;
        final spots = <FlSpot>[];
        for (var i = 0; i < solves.length; i++) {
          final time = solves[i].time.inMilliseconds.toDouble() / 1000;
          final spot = FlSpot(i.toDouble(), time);
          spots.add(spot);
        }
        return Padding(
          padding: const EdgeInsets.all(32),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(spots: spots),
              ],
            ),
          ),
        );
      },
    );
  }
}
