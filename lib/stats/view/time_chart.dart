import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class TimeChart extends StatelessWidget {
  TimeChart({super.key, required this.solves}) {}

  final List<Solve> solves;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(spots: spots),
        ],
      ),
    );
  }

  List<FlSpot> get spots {
    final spots = <FlSpot>[];
    for (var i = 0; i < solves.length; i++) {
      final time = solves[i].time.inMilliseconds.toDouble() / 1000;
      final spot = FlSpot(i.toDouble(), time);
      spots.add(spot);
    }
    return spots;
  }
}
