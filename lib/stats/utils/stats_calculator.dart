import 'package:collection/collection.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/max_stat.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class StatsCalculator {
  static Stat computeBest(List<Solve> solves) {
    final times = _getTimes(solves);
    return BestStat(times.min);
  }

  static Stat computeMean(List<Solve> solves) {
    final times = _getTimes(solves);
    final mean = times.average.round();
    return MeanStat(solves.length, mean);
  }

  static Stat computeAverage(List<Solve> solves) {
    final times = _getTimes(solves);
    final minTimeIndex = times.indexOf(times.min);
    times.removeAt(minTimeIndex);
    final maxTimeIndex = times.indexOf(times.max);
    times.removeAt(maxTimeIndex);
    return AverageStat(solves.length, times.average.round());
  }

  static List<int> _getTimes(List<Solve> solves) {
    return solves
        .map((s) => s.getEffectiveTime().inMilliseconds)
        // Truncate last digit to compute rounding properly
        .map((t) => t - (t % 10))
        .toList();
  }
}
