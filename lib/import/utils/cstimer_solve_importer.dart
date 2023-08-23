import 'dart:convert';

import 'package:kubrs_app/import/utils/solve_importer.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class CSTimerSolveImporter extends SolveImporter {
  @override
  List<Solve> convertRawDataToSolves(String rawData) {
    final json = jsonDecode(rawData) as Map<String, dynamic>;
    final solves = List<Solve>.empty(growable: true);
    for (final key in json.keys) {
      if (!key.startsWith('session')) continue;
      final sessionData = json[key] as List<dynamic>;
      final sessionSolves = _decodeSession(sessionData);
      solves.addAll(sessionSolves);
    }
    return solves;
  }

  List<Solve> _decodeSession(List<dynamic> sessionData) {
    final solves = List<Solve>.empty(growable: true);
    for (final solveData in sessionData) {
      final solve = _decodeSolve(solveData as List<dynamic>);
      solves.add(solve);
    }
    return solves;
  }

  Solve _decodeSolve(List<dynamic> solveData) {
    final solve = Solve.create(
      timestamp: _decodeTimestamp(solveData),
      time: _decodeTime(solveData),
      scramble: _decodeScramble(solveData),
    );
    if (_isDnf(solveData)) return Solve.cloneAndToggleDNF(solve: solve);
    if (_isPlusTwo(solveData)) return Solve.cloneAndTogglePlusTwo(solve: solve);
    return solve;
  }

  DateTime _decodeTimestamp(List<dynamic> solveData) {
    final secondsSinceEpoch = solveData[3] as int;
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  }

  Duration _decodeTime(List<dynamic> solveData) {
    final timeInMillis = (solveData[0] as List<dynamic>)[1] as int;
    return Duration(milliseconds: timeInMillis);
  }

  String _decodeScramble(List<dynamic> solveData) {
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
