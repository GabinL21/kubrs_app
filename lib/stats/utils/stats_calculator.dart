import 'package:collection/collection.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class StatsCalculator {
  static Stat computeMean(List<Solve> solves) {
    final score =
        solves.map((s) => s.getEffectiveTime().inMilliseconds).average.round();
    return MeanStat(solves.length, score);
  }

  static Stat computeAverage(List<Solve> solves) {
    final times =
        solves.map((s) => s.getEffectiveTime().inMilliseconds).toList();
    final minTimeIndex = times.indexOf(times.min);
    times.removeAt(minTimeIndex);
    final maxTimeIndex = times.indexOf(times.max);
    times.removeAt(maxTimeIndex);
    return AverageStat(solves.length, times.average.round());
  }
}
