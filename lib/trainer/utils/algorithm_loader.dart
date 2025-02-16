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
    Map<String, dynamic> jsonMap,
  ) {
    return (jsonMap['groups'] as List<dynamic>).map((group) {
      final groupMap = group as Map<String, dynamic>;
      return AlgorithmGroup(
        id: groupMap['id'] as int,
        name: groupMap['name'] as String,
        algorithms: _parseAlgorithms(groupMap['algorithms'] as List<dynamic>),
      );
    }).toList();
  }

  static List<Algorithm> _parseAlgorithms(List<dynamic> algorithms) {
    return algorithms.map((algorithm) {
      final algorithmMap = algorithm as Map<String, dynamic>;
      return Algorithm(
        id: algorithmMap['id'] as int,
        name: algorithmMap['name'] as String,
        solution: algorithmMap['solution'] as String,
        pattern:
            _parseCubePattern(algorithmMap['pattern'] as Map<String, dynamic>),
        scrambles:
            List<String>.from(algorithmMap['scrambles'] as List<dynamic>),
      );
    }).toList();
  }

  static CubePattern _parseCubePattern(Map<String, dynamic> pattern) {
    return CubePattern(
      uFace: List<int>.from(pattern['U'] as List<dynamic>),
      bSide: List<int>.from(pattern['B'] as List<dynamic>),
      lSide: List<int>.from(pattern['L'] as List<dynamic>),
      rSide: List<int>.from(pattern['R'] as List<dynamic>),
      fSide: List<int>.from(pattern['F'] as List<dynamic>),
    );
  }
}
