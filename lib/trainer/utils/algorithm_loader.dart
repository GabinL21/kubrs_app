import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:kubrs_app/trainer/model/algorithm.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';
import 'package:kubrs_app/trainer/model/cube_pattern.dart';

class AlgorithmLoader {
  static Future<List<AlgorithmGroup>> loadAlgorithmGroups() async {
    final jsonString = await _loadJson();
    final jsonMap = _decodeJson(jsonString);
    return _parseAlgorithmGroups(jsonMap);
  }

  static Future<String> _loadJson() async {
    return rootBundle.loadString('assets/algorithms.json');
  }

  static Map<String, dynamic> _decodeJson(String jsonString) {
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  static List<AlgorithmGroup> _parseAlgorithmGroups(
      Map<String, dynamic> jsonMap) {
    return (jsonMap['groups'] as List).map((group) {
      return AlgorithmGroup(
        id: group['id'] as int,
        name: group['name'] as String,
        algorithms: _parseAlgorithms(group['algorithms'] as List),
      );
    }).toList();
  }

  static List<Algorithm> _parseAlgorithms(List<dynamic> algorithms) {
    return algorithms.map((algorithm) {
      return Algorithm(
        id: algorithm['id'] as int,
        name: algorithm['name'] as String,
        solution: algorithm['solution'] as String,
        pattern:
            _parseCubePattern(algorithm['pattern'] as Map<String, dynamic>),
        scrambles: List<String>.from(algorithm['scrambles'] as List),
      );
    }).toList();
  }

  static CubePattern _parseCubePattern(Map<String, dynamic> pattern) {
    return CubePattern(
      uFace: List<int>.from(pattern['U'] as List),
      bSide: List<int>.from(pattern['B'] as List),
      lSide: List<int>.from(pattern['L'] as List),
      rSide: List<int>.from(pattern['R'] as List),
      fSide: List<int>.from(pattern['F'] as List),
    );
  }
}
