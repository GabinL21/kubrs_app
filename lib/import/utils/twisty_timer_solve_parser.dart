import 'package:kubrs_app/solve/model/solve.dart';

class TwistyTimerSolveParser {
  TwistyTimerSolveParser({required this.uid});

  final String uid;

  List<Solve> parseSolves(String textSolves) {
    final solves = <Solve>[];
    final parsedTextSolves = textSolves.split('\n');
    for (final textSolve in parsedTextSolves) {
      if (textSolve.isEmpty) continue; // Skip empty lines
      final solve = _parseSolve(textSolve);
      solves.add(solve);
    }
    return solves;
  }

  Solve _parseSolve(String textSolve) {
    final textFields = textSolve.split(';').map(_stripStringQuotes).toList();
    final timeInMillis = (double.parse(textFields[0]) * 1000).round();
    final time = Duration(milliseconds: timeInMillis);
    final scramble = textFields[1];
    final timestamp = DateTime.parse(textFields[2]);
    final dnf = textFields.length >= 4 && textFields[3] == 'DNF';
    return Solve.create(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
      dnf: dnf,
    );
  }

  String _stripStringQuotes(String s) {
    return s.substring(1, s.length - 1);
  }
}
