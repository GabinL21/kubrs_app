import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/trainer/utils/algorithm_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AlgorithmLoader', () {
    const mockJson = '''
    {
      "groups": [
        {
          "id": 1,
          "name": "2-Look PLL",
          "algorithms": [
            {
              "id": 1,
              "name": "PLL (H)",
              "solution": "M2 U M2 U2 M2 U M2",
              "pattern": {
                "U": [2, 2, 2, 2, 2, 2, 2, 2, 2],
                "F": [3, 4, 3],
                "R": [5, 6, 5],
                "B": [4, 3, 4],
                "L": [6, 5, 6]
              }
            }
          ]
        }
      ]
    }
    ''';

    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(
        'flutter/assets',
        (message) async {
          final encoded = utf8.encoder.convert(mockJson);
          return encoded.buffer.asByteData();
        },
      );
    });

    test('loadAlgorithmGroups returns a list of AlgorithmGroup', () async {
      final algorithmGroups = await AlgorithmLoader.loadAlgorithmGroups();

      expect(algorithmGroups, isNotNull);
      expect(algorithmGroups.length, 1);

      final group = algorithmGroups.first;
      expect(group.id, 1);
      expect(group.name, '2-Look PLL');
      expect(group.algorithms.length, 1);

      final algorithm = group.algorithms.first;
      expect(algorithm.id, 1);
      expect(algorithm.name, 'PLL (H)');
      expect(algorithm.solution, 'M2 U M2 U2 M2 U M2');

      final pattern = algorithm.pattern;
      expect(pattern.uFace, [2, 2, 2, 2, 2, 2, 2, 2, 2]);
      expect(pattern.fSide, [3, 4, 3]);
      expect(pattern.rSide, [5, 6, 5]);
      expect(pattern.bSide, [4, 3, 4]);
      expect(pattern.lSide, [6, 5, 6]);
    });
  });
}
