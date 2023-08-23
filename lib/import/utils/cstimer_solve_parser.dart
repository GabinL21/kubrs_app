import 'dart:convert';

import 'package:kubrs_app/solve/model/solve.dart';

class CSTimerSolveParser {
  CSTimerSolveParser({required this.uid});

  final String uid;

  List<Solve> parseSolves(String textSolves) {
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

  List<Solve> _parseSession(List<dynamic> sessionData) {
    final solves = <Solve>[];
    for (final solveData in sessionData) {
      final solve = _parseSolve(solveData as List<dynamic>);
      solves.add(solve);
    }
    return solves;
  }

  Solve _parseSolve(List<dynamic> solveData) {
    final solve = Solve.create(
      uid: uid,
      timestamp: _parseTimestamp(solveData),
      time: _parseTime(solveData),
      scramble: _parseScramble(solveData),
    );
    if (_isDnf(solveData)) return Solve.cloneAndToggleDNF(solve: solve);
    if (_isPlusTwo(solveData)) return Solve.cloneAndTogglePlusTwo(solve: solve);
    return solve;
  }

  DateTime _parseTimestamp(List<dynamic> solveData) {
    final secondsSinceEpoch = solveData[3] as int;
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  }

  Duration _parseTime(List<dynamic> solveData) {
    final timeInMillis = (solveData[0] as List<dynamic>)[1] as int;
    return Duration(milliseconds: timeInMillis);
  }

  String _parseScramble(List<dynamic> solveData) {
    return solveData[1] as String;
  }

  bool _isPlusTwo(List<dynamic> solveData) {
    final penalty = (solveData[0] as List<dynamic>)[0] as int;
    return penalty == 2000;
  }

  bool _isDnf(List<dynamic> solveData) {
    final penalty = (solveData[0] as List<dynamic>)[0] as int;
    return penalty == -1;
  }
}
