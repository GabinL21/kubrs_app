import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/import/utils/cube_desk_solve_parser.dart';
import 'package:kubrs_app/solve/model/solve.dart';

const String textSolves = '''
{
  "sessions": [
    {
      "id": "aeca5b6d-992b-4734-a761-035502905cac",
      "name": "New Session",
      "created_at": "2023-07-19T13:31:38.302Z",
      "order": 0
    }
  ],
  "solves": [
    {
      "id": "ef68a9db-7b77-4333-b061-2d2c1587c7d1",
      "time": 36.509,
      "raw_time": 36.509,
      "cube_type": "333",
      "session_id": "aeca5b6d-992b-4734-a761-035502905cac",
      "trainer_name": null,
      "bulk": false,
      "scramble": "U' F2 U L2 U' L2 D' L2 B2 U2 F2 U' L' U2 R' U L2 B F D2 U'",
      "from_timer": true,
      "training_session_id": null,
      "dnf": false,
      "plus_two": false,
      "is_smart_cube": false,
      "created_at": "2023-07-22T10:55:03.998Z",
      "started_at": 1690023266802,
      "ended_at": 1690023303311
    },
    {
      "id": "cf465fe4-85c4-4633-a9ef-fad49c83e6df",
      "time": 50.538,
      "raw_time": 50.538,
      "cube_type": "333",
      "session_id": "aeca5b6d-992b-4734-a761-035502905cac",
      "trainer_name": null,
      "bulk": false,
      "scramble": "B2 F2 L2 U R2 D B2 D' B2 U2 L2 R' D L' B' F U' B2 R' F2 R'",
      "from_timer": true,
      "training_session_id": null,
      "dnf": false,
      "plus_two": true,
      "is_smart_cube": false,
      "created_at": "2023-07-22T10:53:56.696Z",
      "started_at": 1690023185468,
      "ended_at": 1690023236006
    },
    {
      "id": "cf465fe4-85c4-4633-a9ef-fad49c83e6df",
      "time": 50.538,
      "raw_time": 50.538,
      "cube_type": "222",
      "session_id": "aeca5b6d-992b-4734-a761-035502905cac",
      "trainer_name": null,
      "bulk": false,
      "scramble": "B2 F2 L2 U R2 D B2 D' B2 U2 L2 R' D L' B' F U' B2 R' F2 R'",
      "from_timer": true,
      "training_session_id": null,
      "dnf": false,
      "plus_two": false,
      "is_smart_cube": false,
      "created_at": "2023-07-22T10:53:56.696Z",
      "started_at": 1690023185468,
      "ended_at": 1690023236006
    },
    {
      "id": "6f0e119b-58c7-4cf8-b9ee-75e443bc17ff",
      "time": 34.559,
      "raw_time": 34.559,
      "cube_type": "333",
      "session_id": "aeca5b6d-992b-4734-a761-035502905cac",
      "trainer_name": null,
      "bulk": false,
      "scramble": "R2 F2 L2 U F2 D L2 U2 B2 L2 D L2 F' U2 L' F D' L2 B R B2 U",
      "from_timer": true,
      "training_session_id": null,
      "dnf": true,
      "plus_two": false,
      "is_smart_cube": false,
      "created_at": "2023-07-22T10:52:25.826Z",
      "started_at": 1690023110570,
      "ended_at": 1690023145129
    }
  ]
}
''';

void main() {
  group('CubeDeskSolveParser', () {
    late List<Solve> solves;

    setUp(() {
      solves = CubeDeskSolveParser.parseSolves(textSolves);
    });

    test('parses the right number of solves and skips solves other than 3x3',
        () {
      expect(solves.length, 3);
    });

    test('parses solves without penalty correctly', () {
      final actualSolve = solves[0];
      final expectedSolve = Solve.create(
        timestamp: DateTime.parse('2023-07-22T10:55:03.998Z'),
        time: const Duration(milliseconds: 36509),
        scramble: "U' F2 U L2 U' L2 D' L2 B2 U2 F2 U' L' U2 R' U L2 B F D2 U'",
      );
      expect(actualSolve, expectedSolve);
    });

    test('parses +2 solves correctly', () {
      final actualSolve = solves[1];
      final expectedSolve = Solve.create(
        timestamp: DateTime.parse('2023-07-22T10:53:56.696Z'),
        time: const Duration(milliseconds: 50538),
        scramble: "B2 F2 L2 U R2 D B2 D' B2 U2 L2 R' D L' B' F U' B2 R' F2 R'",
        plusTwo: true,
      );
      expect(actualSolve, expectedSolve);
    });

    test('parses DNF solves correctly', () {
      final actualSolve = solves[2];
      final expectedSolve = Solve.create(
        timestamp: DateTime.parse('2023-07-22T10:52:25.826Z'),
        time: const Duration(milliseconds: 34559),
        scramble: "R2 F2 L2 U F2 D L2 U2 B2 L2 D L2 F' U2 L' F D' L2 B R B2 U",
        dnf: true,
      );
      expect(actualSolve, expectedSolve);
    });
  });
}
