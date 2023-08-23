import 'package:collection/collection.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/best_stat.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/model/stat.dart';
import 'package:kubrs_app/stats/model/worst_stat.dart';

class StatsCalculator {
  static Stat computeBest(List<Solve> solves) {
    if (solves.isEmpty) return BestStat.empty();
    if (solves.every((s) => s.dnf)) return BestStat.dnf();
    final times = _getTimes(solves);
    return BestStat(times.min);
  }

  static Stat computeWorst(List<Solve> solves) {
    if (solves.isEmpty) return WorstStat.empty();
    if (solves.every((s) => s.dnf)) return WorstStat.dnf();
    final nonDnfSolves = solves.where((s) => !s.dnf);
    final times = _getTimes(nonDnfSolves);
    return WorstStat(times.max);
  }

  static Stat computeMean(List<Solve> solves, [int? nbSolves]) {
    if (solves.isEmpty) return MeanStat.empty(nbSolves ?? solves.length);
    if (solves.every((s) => s.dnf)) {
      return MeanStat.dnf(nbSolves ?? solves.length);
    }
    final nonDnfSolves = solves.where((s) => !s.dnf);
    if (nbSolves != null && (nbSolves <= 0 || nbSolves > nonDnfSolves.length)) {
      return MeanStat.empty(nbSolves);
    }
    final meanSolves =
        nbSolves == null ? nonDnfSolves : nonDnfSolves.take(nbSolves);
    final times = _getTimes(meanSolves);
    final mean = times.average.floor();
    return MeanStat(mean, nbSolves ??= nonDnfSolves.length);
  }

  static Stat computeAverage(List<Solve> solves, int nbSolves) {
    if (nbSolves < 3 || nbSolves > solves.length) {
      return AverageStat.empty(nbSolves);
    }
    final averageSolves = solves.take(nbSolves);
    final nbDnfSolves = averageSolves.where((s) => s.dnf).length;
    if (nbDnfSolves >= 2) {
      return AverageStat.dnf(nbSolves);
    }
    final times = _getTimes(averageSolves);
    final minTimeIndex = times.indexOf(times.min);
    times.removeAt(minTimeIndex);
    final maxTimeIndex = times.indexOf(times.max);
    times.removeAt(maxTimeIndex);
    final average = times.average.floor();
    return AverageStat(average, nbSolves);
  }

  static Stat computeBestAverage(List<Solve> solves, int nbSolves) {
    Stat bestAverage = AverageStat.empty(nbSolves);
    for (var i = 0; i <= solves.length - nbSolves; i++) {
      final average = computeAverage(solves.sublist(i, i + nbSolves), nbSolves);
      if (bestAverage < average) bestAverage = average;
    }
    return bestAverage;
  }

  static List<int> _getTimes(Iterable<Solve> solves) {
    return solves.map((s) => s.effectiveTime.inMilliseconds).toList();
  }
}
