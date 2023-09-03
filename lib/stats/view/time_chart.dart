import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class TimeChart extends StatelessWidget {
  const TimeChart({super.key, required this.solves});

  final List<Solve> solves;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          minY: minTime - 3,
          maxY: maxTime + 3,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              color: theme.colorScheme.tertiary,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              isCurved: true,
              isStrokeCapRound: true,
              preventCurveOverShooting: true,
            ),
          ],
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(),
            leftTitles: AxisTitles(),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          backgroundColor: theme.colorScheme.surface,
        ),
      ),
    );
  }

  List<FlSpot> get spots {
    final spots = <FlSpot>[];
    for (var i = 0; i < solves.length; i++) {
      final time = solves[i].effectiveTime.inMilliseconds.toDouble() / 1000;
      final spot = FlSpot(i.toDouble(), time);
      spots.add(spot);
    }
    return spots;
  }

  double get minTime {
    return solves
            .map((solve) => solve.effectiveTime)
            .min
            .inMilliseconds
            .toDouble() /
        1000;
  }

  double get maxTime {
    return solves
            .map((solve) => solve.effectiveTime)
            .min
            .inMilliseconds
            .toDouble() /
        1000;
  }
}
