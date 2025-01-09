import 'dart:convert';
import 'dart:io';

import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';
import 'package:test/test.dart';

void main() {
  group('algorithms.json', () {
    late Map<String, dynamic> jsonData;

    setUpAll(() async {
      final file = File('assets/algorithms.json');
      final content = await file.readAsString();
      jsonData = jsonDecode(content) as Map<String, dynamic>;
    });

    test('should have unique IDs', () {
      final ids = <int>{};
      for (final group in jsonData['groups']! as List<dynamic>) {
        _validateUniqueIds(group as Map<String, dynamic>, ids);
      }
    });

    test('should have valid format', () {
      expect(jsonData, isA<Map<String, dynamic>>());
      expect(jsonData['groups'], isA<List>());

      for (final group in jsonData['groups']! as List<dynamic>) {
        _validateGroupFormat(group as Map<String, dynamic>);
      }
    });
  });
}

void _validateUniqueIds(Map<String, dynamic> group, Set<int> ids) {
  for (final algorithm in group['algorithms']! as List<dynamic>) {
    final id = algorithm['id']! as int;
    expect(ids.contains(id), isFalse, reason: 'Duplicate ID found: $id');
    ids.add(id);
  }
}

void _validateGroupFormat(Map<String, dynamic> group) {
  expect(group, isA<Map<String, dynamic>>());
  expect(group['id'], isA<int>());
  expect(group['name'], isA<String>());
  expect(group['algorithms'], isA<List>());

  for (final algorithm in group['algorithms']! as List<dynamic>) {
    _validateAlgorithmFormat(algorithm as Map<String, dynamic>);
  }
}

void _validateAlgorithmFormat(Map<String, dynamic> algorithm) {
  expect(algorithm, isA<Map<String, dynamic>>());
  expect(algorithm['id'], isA<int>());
  expect(algorithm['name'], isA<String>());
  expect(algorithm['solution'], isA<String>());
  expect(algorithm['pattern'], isA<Map<String, dynamic>>());
  expect(algorithm['scrambles'], isA<List>());

  _validatePattern(algorithm['pattern']! as Map<String, dynamic>);
  _validateScrambles(algorithm['scrambles']! as List<dynamic>);
}

void _validatePattern(Map<String, dynamic> pattern) {
  expect(pattern.keys, containsAll(['U', 'F', 'R', 'B', 'L']));
  for (final face in pattern.keys) {
    final expectedLength = face == 'U' ? 9 : 3;
    expect(pattern[face], hasLength(expectedLength));
    for (final color in pattern[face]! as List<dynamic>) {
      expect(color, isA<int>());
      expect(color, greaterThanOrEqualTo(0));
      expect(color, lessThanOrEqualTo(6));
    }
  }
}

void _validateScrambles(List<dynamic> scrambles) {
  for (final scramble in scrambles) {
    expect(scramble, isA<String>());
    expect(() => Cube.getScrambledCube(scramble as String), returnsNormally);
  }
}
