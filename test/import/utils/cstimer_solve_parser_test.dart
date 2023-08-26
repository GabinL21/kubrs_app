import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/import/utils/cstimer_solve_parser.dart';
import 'package:kubrs_app/solve/model/solve.dart';

const String textSolves = '''
{
  "session1": [
    [
      [
        0,
        1437
      ],
      "L B2 R2 F' U2 B R F2 U F R2 U2 F B L2 F R2 U2 B' L2",
      "",
      1692708489
    ],
    [
      [
        2000,
        1411
      ],
      "F D2 B' R2 B' R2 F2 L2 D2 F U2 F2 U F R' U2 F U L2 F R'",
      "",
      1692708492
    ]
  ],
  "session2": [],
  "session3": [
    [
      [
        -1,
        1645
      ],
      "U' B2 U2 F2 R2 D' B2 U' F2 R2 D2 B2 R' U' R2 D' U' L' R' U'",
      "",
      1692708500
    ]
  ],
  "properties": {
    "sessionData": "..."
  }
}
''';

void main() {
  group('CSTimerSolveParser', () {
    late List<Solve> solves;

    setUp(() {
      solves = CSTimerSolveParser.parseSolves(textSolves);
    });

    test('parses the right number of solves', () {
      expect(solves.length, 3);
    });

    test('parses solves without penalty correctly', () {
      final actualSolve = solves[0];
      final expectedSolve = Solve.create(
        timestamp: DateTime.fromMillisecondsSinceEpoch(1692708489 * 1000),
        time: const Duration(milliseconds: 1437),
        scramble: "L B2 R2 F' U2 B R F2 U F R2 U2 F B L2 F R2 U2 B' L2",
      );
      expect(actualSolve, expectedSolve);
    });

    test('parses +2 solves correctly', () {
      final actualSolve = solves[1];
      final expectedSolve = Solve.create(
        timestamp: DateTime.fromMillisecondsSinceEpoch(1692708492 * 1000),
        time: const Duration(milliseconds: 1411),
        scramble: "F D2 B' R2 B' R2 F2 L2 D2 F U2 F2 U F R' U2 F U L2 F R'",
        plusTwo: true,
      );
      expect(actualSolve, expectedSolve);
    });

    test('parses DNF solves correctly', () {
      final actualSolve = solves[2];
      final expectedSolve = Solve.create(
        timestamp: DateTime.fromMillisecondsSinceEpoch(1692708500 * 1000),
        time: const Duration(milliseconds: 1645),
        scramble: "U' B2 U2 F2 R2 D' B2 U' F2 R2 D2 B2 R' U' R2 D' U' L' R' U'",
        dnf: true,
      );
      expect(actualSolve, expectedSolve);
    });
  });
}
