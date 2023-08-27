import 'dart:convert';

import 'package:kubrs_app/solve/model/solve.dart';

class CubeDeskSolveParser {
  CubeDeskSolveParser();

  static List<Solve> parseSolves(String textSolves) {
    final solves = <Solve>[];
    final importDateTime = DateTime.now();
    final json = jsonDecode(textSolves) as Map<String, dynamic>;
    final jsonSolves = json['solves'] as List<dynamic>;
    for (final jsonSolve in jsonSolves) {
      jsonSolve as Map<String, dynamic>;
      if (jsonSolve['cube_type'] != '333') continue;
      final solve = _parseSolve(jsonSolve, importDateTime);
      solves.add(solve);
    }
    return solves;
  }

  static Solve _parseSolve(
    Map<String, dynamic> jsonSolve,
    DateTime importDateTime,
  ) {
    final timestamp = DateTime.parse(jsonSolve['created_at'] as String);
    final timeInMillis = ((jsonSolve['time'] as double) * 1000).floor();
    final time = Duration(milliseconds: timeInMillis);
    final scramble = jsonSolve['scramble'] as String;
    final plusTwo = jsonSolve['plus_two'] as bool;
    final dnf = jsonSolve['dnf'] as bool;
    return Solve(
      timestamp: timestamp,
      time: time,
      scramble: scramble,
      plusTwo: plusTwo,
      dnf: dnf,
      lastUpdate: importDateTime,
    );
  }
}
