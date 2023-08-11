import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/best_stat.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/model/worst_stat.dart';
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

    final dnfSolves = List.generate(5, (_) => _buildDnfSolve(60000));

    final solvesWithDnf = <Solve>[
      ...solvesWithPlusTwo,
      _buildDnfSolve(5000),
      _buildDnfSolve(15000),
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

      test('returns DNF best when every solve is DNF', () {
        final bestStat = StatsCalculator.computeBest(dnfSolves);
        expect(bestStat, BestStat.dnf());
      });

      test('filters DNF solves when not every solve is DNF', () {
        final bestStat = StatsCalculator.computeBest(solvesWithDnf);
        expect(bestStat, BestStat(7000));
      });

      test('computes best with +2 correctly', () {
        final bestStat = StatsCalculator.computeBest(solvesWithPlusTwo);
        expect(bestStat, BestStat(7000));
      });
    });

    group('WorstStat', () {
      test('returns empty worst when solves are empty', () {
        final worstStat = StatsCalculator.computeWorst(List.empty());
        expect(worstStat, WorstStat.empty());
      });

      test('returns DNF worst when every solve is DNF', () {
        final worstStat = StatsCalculator.computeWorst(dnfSolves);
        expect(worstStat, WorstStat.dnf());
      });

      test('filters DNF solves when not every solve is DNF', () {
        final worstStat = StatsCalculator.computeWorst(solvesWithDnf);
        expect(worstStat, WorstStat(11000));
      });

      test('computes worst with +2 correctly', () {
        final worstStat = StatsCalculator.computeWorst(solvesWithPlusTwo);
        expect(worstStat, WorstStat(11000));
      });
    });

    group('MeanStat', () {
      test('returns empty mean when solves are empty', () {
        final meanStat = StatsCalculator.computeMean(List.empty());
        expect(meanStat, MeanStat.empty(0));
      });

      test('returns DNF mean when every solve is DNF', () {
        final meanStat = StatsCalculator.computeMean(dnfSolves);
        expect(meanStat, MeanStat.dnf(dnfSolves.length));
      });

      test('filters DNF solves when not every solve is DNF', () {
        final meanStat = StatsCalculator.computeMean(solvesWithDnf, 5);
        expect(meanStat, MeanStat(10000, 5));
      });

      test('returns empty mean when solves without DNFs are not enough', () {
        final meanStat = StatsCalculator.computeMean(solvesWithDnf, 7);
        expect(meanStat, MeanStat.empty(7));
      });

      test('computes mean with +2 correctly', () {
        final meanStat = StatsCalculator.computeMean(solvesWithPlusTwo);
        expect(meanStat, MeanStat(10000, 5));
      });

      test('rounds last digits when computing mean', () {
        final meanStat = StatsCalculator.computeMean(solvesWithLastDigits);
        expect(meanStat, MeanStat(10006, 5));
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

      test('returns DNF average when more than 1 solve is DNF', () {
        final averageStat = StatsCalculator.computeAverage(solvesWithDnf, 7);
        expect(averageStat, AverageStat.dnf(solvesWithDnf.length));
      });

      test(
          'returns correct average when more than 1 solve is DNF '
          'but not in the average of range', () {
        final averageStat = StatsCalculator.computeAverage(solvesWithDnf, 5);
        expect(averageStat, AverageStat(10667, 5));
      });

      test('computes average with +2 correctly', () {
        final averageStat =
            StatsCalculator.computeAverage(solvesWithPlusTwo, 5);
        expect(averageStat, AverageStat(10667, 5));
      });

      test('rounds last digits when computing average', () {
        final averageStat =
            StatsCalculator.computeAverage(solvesWithLastDigits, 5);
        expect(averageStat, AverageStat(10007, 5));
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

Solve _buildDnfSolve(int timeInMillis) {
  return Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: Duration(milliseconds: timeInMillis),
    scramble: '',
    dnf: true,
  );
}
