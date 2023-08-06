import 'package:collection/collection.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';
import 'package:kubrs_app/stats/model/stat.dart';

class StatsCalculator {
  static Stat computeMean(List<Solve> solves) {
    final score =
        solves.map((s) => s.getEffectiveTime().inMilliseconds).average.toInt();
    return MeanStat(solves.length, score);
  }
}
