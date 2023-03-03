import 'dart:math';

import 'package:cuber/cuber.dart';

class Scramble {
  static String generate() {
    Cube cube;
    do {
      cube = _getRandomStateCube();
    } while (cube.isNotOk);
    final solution = cube.solve();
    if (solution == null) return 'Scramble failed to load';
    return solution.toString();
  }

  static Cube _getRandomStateCube() {
    final cp = [0, 1, 2, 3, 4, 5, 6, 7]..shuffle();
    final co = List.generate(8, (_) => Random().nextInt(3));
    final ep = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]..shuffle();
    final eo = List.generate(12, (_) => Random().nextInt(2));
    final json = {'cp': cp, 'co': co, 'ep': ep, 'eo': eo};
    return Cube.fromJson(json);
  }
}
