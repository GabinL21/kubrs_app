import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

class TimeChart extends StatelessWidget {
  const TimeChart({
    super.key,
    required this.solves,
    this.minimalist = false,
    this.minSolves = 0,
  });

  final List<Solve> solves;
  final bool minimalist;
  final int minSolves;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor =
        minimalist ? Colors.transparent : theme.colorScheme.surface;
    return LineChart(
      LineChartData(
        minX: 1,
        maxX: solves.length > minSolves
            ? solves.length.toDouble()
            : minSolves.toDouble(),
        minY: minTime.floorToDouble(),
        maxY: maxTime.ceilToDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            color: theme.colorScheme.tertiary,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            isCurved: true,
            isStrokeCapRound: true,
            preventCurveOverShooting: true,
          ),
        ],
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          bottomTitles: const AxisTitles(),
          leftTitles: const AxisTitles(),
          rightTitles: minimalist
              ? const AxisTitles()
              : const AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 44,
                    showTitles: true,
                  ),
                ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        backgroundColor: surfaceColor,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: theme.colorScheme.tertiary,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map(
                (LineBarSpot touchedSpot) {
                  final duration =
                      Duration(milliseconds: (touchedSpot.y * 1000).floor());
                  return LineTooltipItem(
                    DurationFormatter.format(duration),
                    theme.textTheme.displaySmall!.copyWith(
                      color: theme.colorScheme.onTertiary,
                    ),
                  );
                },
              ).toList();
            },
          ),
        ),
      ),
    );
  }

  List<FlSpot> get spots {
    final spots = <FlSpot>[];
    for (var i = 0; i < solves.length; i++) {
      final time = solves[i].effectiveTime.inMilliseconds.toDouble() / 1000;
      final spot = FlSpot(i.toDouble() + 1, time);
      spots.add(spot);
    }
    return spots;
  }

  double get minTime {
    if (solves.isEmpty) return 0;
    return solves
            .map((solve) => solve.effectiveTime)
            .min
            .inMilliseconds
            .toDouble() /
        1000;
  }

  double get maxTime {
    if (solves.isEmpty) return 10;
    return solves
            .map((solve) => solve.effectiveTime)
            .max
            .inMilliseconds
            .toDouble() /
        1000;
  }
}
