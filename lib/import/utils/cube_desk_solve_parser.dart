import 'dart:convert';

import 'package:kubrs_app/solve/model/solve.dart';

class CubeDeskSolveParser {
  CubeDeskSolveParser({required this.uid});

  final String uid;

  List<Solve> parseSolves(String textSolves) {
    final json = jsonDecode(textSolves) as Map<String, dynamic>;
    final solves = <Solve>[];
    final jsonSolves = json['solves'] as List<dynamic>;
    for (final jsonSolve in jsonSolves) {
      jsonSolve as Map<String, dynamic>;
      if (jsonSolve['cube_type'] != '333') continue;
      final solve = _parseSolve(jsonSolve);
      solves.add(solve);
    }
    return solves;
  }

  Solve _parseSolve(Map<String, dynamic> jsonSolve) {
    final timestamp = DateTime.parse(jsonSolve['created_at'] as String);
    final timeInMillis = ((jsonSolve['time'] as double) * 1000).round();
    final time = Duration(milliseconds: timeInMillis);
    final scramble = jsonSolve['scramble'] as String;
    final plusTwo = jsonSolve['plus_two'] as bool;
    final dnf = jsonSolve['dnf'] as bool;
    return Solve.create(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
      plusTwo: plusTwo,
      dnf: dnf,
    );
  }
}
