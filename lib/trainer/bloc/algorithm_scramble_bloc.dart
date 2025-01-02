import 'dart:math';

import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/trainer/model/algorithm_group.dart';

class AlgorithmScrambleBloc extends ScrambleBloc {
  AlgorithmScrambleBloc(this.algorithmGroup) : super();

  @override
  Future<String> generateScramble() async {
    final random = Random();
    final algorithmIndex = random.nextInt(algorithmGroup.algorithms.length);
    final algorithm = algorithmGroup.algorithms[algorithmIndex];
    final scrambleIndex = random.nextInt(algorithm.scrambles.length);
    return algorithm.scrambles[scrambleIndex];
  }

  final AlgorithmGroup algorithmGroup;
}
