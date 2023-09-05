import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/session/bloc/session_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

class SessionChart extends StatelessWidget {
  const SessionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: _getSpots(state.solves),
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
              rightTitles: AxisTitles(),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: theme.colorScheme.tertiary,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map(
                    (LineBarSpot touchedSpot) {
                      final duration = Duration(
                        milliseconds: (touchedSpot.y * 1000).floor(),
                      );
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
      },
    );
  }

  List<FlSpot> _getSpots(List<Solve> solves) {
    final spots = <FlSpot>[];
    for (var i = 0; i < solves.length; i++) {
      final time = solves[i].effectiveTime.inMilliseconds.toDouble() / 1000;
      final spot = FlSpot(i.toDouble(), time);
      spots.add(spot);
    }
    return spots;
  }
}
