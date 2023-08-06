import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/utils/stats_calculator.dart';

void main() {
  group('StatsCalculator', () {
    final solvesWithPlusTwo = [
      _buildSolve(11000),
      _buildPlusTwoSolve(8000),
      _buildSolve(7000),
      _buildPlusTwoSolve(9000),
      _buildSolve(11000),
    ];

    test('compute mean with +2 correctly', () {
      final meanStat = StatsCalculator.computeMean(solvesWithPlusTwo);
      expect(meanStat, MeanStat(5, 10000));
    });

    test('compute average with +2 correctly', () {
      final averageStat = StatsCalculator.computeAverage(solvesWithPlusTwo);
      expect(averageStat, AverageStat(5, 10667));
    });
  });
}

Solve _buildSolve(int timeInMillis) {
  return Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: Duration(milliseconds: timeInMillis),
    scramble: '',
  );
}

Solve _buildPlusTwoSolve(int timeInMillis) {
  return Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: Duration(milliseconds: timeInMillis),
    scramble: '',
    plusTwo: true,
  );
}
