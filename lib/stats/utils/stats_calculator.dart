import 'package:collection/collection.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/max_stat.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class StatsCalculator {
  static Stat computeBest(List<Solve> solves) {
    if (solves.isEmpty) return BestStat.empty();
    final times = _getTimes(solves);
    return BestStat(times.min);
  }

  static Stat computeMean(List<Solve> solves, [int? nbSolves]) {
    nbSolves ??= solves.length;
    if (nbSolves <= 0 || nbSolves > solves.length) {
      return MeanStat.empty(nbSolves);
    }
    final times = _getTimes(solves.take(nbSolves));
    final mean = times.average.round();
    return MeanStat(mean, nbSolves);
  }

  static Stat computeAverage(List<Solve> solves, [int? nbSolves]) {
    nbSolves ??= solves.length;
    if (nbSolves <= 0 || nbSolves > solves.length) {
      return AverageStat.empty(nbSolves);
    }
    final times = _getTimes(solves.take(nbSolves));
    final minTimeIndex = times.indexOf(times.min);
    times.removeAt(minTimeIndex);
    final maxTimeIndex = times.indexOf(times.max);
    times.removeAt(maxTimeIndex);
    final average = times.average.round();
    return AverageStat(average, nbSolves);
  }

  static List<int> _getTimes(Iterable<Solve> solves) {
    return solves
        .map((s) => s.getEffectiveTime().inMilliseconds)
        // Truncate last digit to compute rounding properly
        .map((t) => t - (t % 10))
        .toList();
  }
}
