import 'dart:math';

import 'package:kubrs_app/scramble/utils/scramble_generator.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';

class TrainerScrambleGenerator extends ScrambleGenerator {
  TrainerScrambleGenerator({required this.algorithmGroup});

  final AlgorithmGroup algorithmGroup;

  @override
  Future<String> generate() async {
    final random = Random();
    final algorithmIndex = random.nextInt(algorithmGroup.algorithms.length);
    final algorithm = algorithmGroup.algorithms[algorithmIndex];
    final scrambleIndex = random.nextInt(algorithm.scrambles.length);
    return algorithm.scrambles[scrambleIndex];
  }
}
