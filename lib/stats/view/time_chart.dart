import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

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
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(),
            leftTitles: AxisTitles(),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          backgroundColor: theme.colorScheme.surface,
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
            .max
            .inMilliseconds
            .toDouble() /
        1000;
  }
}
