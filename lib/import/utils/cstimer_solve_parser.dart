import 'dart:convert';

import 'package:kubrs_app/solve/model/solve.dart';

class CSTimerSolveParser {
  CSTimerSolveParser();

  static List<Solve> parseSolves(String textSolves) {
    final json = jsonDecode(textSolves) as Map<String, dynamic>;
    final solves = <Solve>[];
    for (final key in json.keys) {
      if (!key.startsWith('session')) continue;
      final sessionData = json[key] as List<dynamic>;
      final sessionSolves = _parseSession(sessionData);
      solves.addAll(sessionSolves);
    }
    return solves;
  }

  static List<Solve> _parseSession(List<dynamic> sessionData) {
    final solves = <Solve>[];
    for (final solveData in sessionData) {
      final solve = _parseSolve(solveData as List<dynamic>);
      solves.add(solve);
    }
    return solves;
  }

  static Solve _parseSolve(List<dynamic> solveData) {
    return Solve.create(
      timestamp: _parseTimestamp(solveData),
      time: _parseTime(solveData),
      scramble: _parseScramble(solveData),
      plusTwo: _parsePlusTwo(solveData),
      dnf: _parseDnf(solveData),
    );
  }

  static DateTime _parseTimestamp(List<dynamic> solveData) {
    final secondsSinceEpoch = solveData[3] as int;
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  }

  static Duration _parseTime(List<dynamic> solveData) {
    final timeInMillis = (solveData[0] as List<dynamic>)[1] as int;
    return Duration(milliseconds: timeInMillis);
  }

  static String _parseScramble(List<dynamic> solveData) {
    return solveData[1] as String;
  }

  static bool _parsePlusTwo(List<dynamic> solveData) {
    final penalty = (solveData[0] as List<dynamic>)[0] as int;
    return penalty == 2000;
  }

  static bool _parseDnf(List<dynamic> solveData) {
    final penalty = (solveData[0] as List<dynamic>)[0] as int;
    return penalty == -1;
  }
}
