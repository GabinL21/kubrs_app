import 'package:collection/collection.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class StatsCalculator {
  static double computeMean(List<Solve> solves) {
    return solves.map((s) => s.getEffectiveTime().inMilliseconds).average;
  }
}
