import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/max_stat.dart';
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

    final sevenSolves = <Solve>[
      ...solvesWithPlusTwo,
      _buildPlusTwoSolve(12000),
      _buildSolve(5000),
    ];

    final solvesWithLastDigits = [
      _buildSolve(10001),
      _buildSolve(10003),
      _buildSolve(10006),
      _buildSolve(10008),
      _buildSolve(10009),
    ];

    group('BestStat', () {
      test('returns empty best when solves are empty', () {
        final bestStat = StatsCalculator.computeBest(List.empty());
        expect(bestStat, BestStat.empty());
      });

      test('computes best with +2 correctly', () {
        final bestStat = StatsCalculator.computeBest(solvesWithPlusTwo);
        expect(bestStat, BestStat(7000));
      });
    });

    group('MeanStat', () {
      test('returns empty mean when solves are empty', () {
        final meanStat = StatsCalculator.computeMean(List.empty(), 5);
        expect(meanStat, MeanStat.empty(5));
      });

      test('computes mean with +2 correctly', () {
        final meanStat = StatsCalculator.computeMean(solvesWithPlusTwo);
        expect(meanStat, MeanStat(10000, 5));
      });

      test('truncates last digits when computing mean', () {
        final meanStat = StatsCalculator.computeMean(solvesWithLastDigits);
        expect(meanStat, MeanStat(10000, 5));
      });

      test('computes mean of 5 with more than 5 solves correctly', () {
        final meanStat = StatsCalculator.computeMean(sevenSolves, 5);
        expect(meanStat, MeanStat(10000, 5));
      });
    });

    group('AverageStat', () {
      test('returns empty average when solves are empty', () {
        final averageStat = StatsCalculator.computeAverage(List.empty(), 5);
        expect(averageStat, AverageStat.empty(5));
      });

      test('computes average with +2 correctly', () {
        final averageStat = StatsCalculator.computeAverage(solvesWithPlusTwo);
        expect(averageStat, AverageStat(10667, 5));
      });

      test('truncates last digits when computing average', () {
        final averageStat =
            StatsCalculator.computeAverage(solvesWithLastDigits);
        expect(averageStat, AverageStat(10000, 5));
      });

      test('computes average of 5 with more than 5 solves correctly', () {
        final averageStat = StatsCalculator.computeAverage(sevenSolves, 5);
        expect(averageStat, AverageStat(10667, 5));
      });
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
