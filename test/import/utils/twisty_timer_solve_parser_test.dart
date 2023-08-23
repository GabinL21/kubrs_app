import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/import/utils/twisty_timer_solve_parser.dart';
import 'package:kubrs_app/solve/model/solve.dart';

const String textSolves = '''
"3.30";"D L2 U L2 U L2 U R2 U B2 R' U2 B2 U F D' L2 R D' F U";"2023-08-23T19:16:58.515+02:00"
"2.05";"U' L2 D F2 D' B2 U' R D2 B' L' F' L2 R2 D' F L' F D'";"2023-08-23T19:17:21.071+02:00";"DNF"

''';

void main() {
  group('TwistyTimerSolveParser', () {
    late List<Solve> solves;

    setUp(() {
      solves = TwistyTimerSolveParser(uid: '').parseSolves(textSolves);
    });

    test('parses the right number of solves', () {
      expect(solves.length, 2);
    });

    test('parses solves without penalty correctly', () {
      final actualSolve = solves[0];
      final expectedSolve = Solve(
        uid: '',
        timestamp: DateTime.parse('2023-08-23T19:16:58.515+02:00'),
        time: const Duration(milliseconds: 3300),
        scramble: "D L2 U L2 U L2 U R2 U B2 R' U2 B2 U F D' L2 R D' F U",
      );
      expect(actualSolve, expectedSolve);
    });

    test('parses DNF solves correctly', () {
      final actualSolve = solves[1];
      final expectedSolve = Solve(
        uid: '',
        timestamp: DateTime.parse('2023-08-23T19:17:21.071+02:00'),
        time: const Duration(milliseconds: 2050),
        scramble: "U' L2 D F2 D' B2 U' R D2 B' L' F' L2 R2 D' F L' F D'",
        dnf: true,
      );
      expect(actualSolve, expectedSolve);
    });
  });
}
