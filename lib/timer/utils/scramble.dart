import 'dart:math';

import 'package:collection/collection.dart';
import 'package:cuber/cuber.dart';

class Scramble {
  static String generate() {
    final cube = _getRandomStateCube();
    final solution = cube.solve();
    if (solution == null) return 'Scramble failed to load';
    return solution.toString();
  }

  static Cube _getRandomStateCube() {
    Cube cube;
    final co = _getCornerOrientations();
    final eo = _getEdgeOrientations();
    do {
      final cp = [0, 1, 2, 3, 4, 5, 6, 7]..shuffle();
      final ep = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]..shuffle();
      final json = {'cp': cp, 'co': co, 'ep': ep, 'eo': eo};
      cube = Cube.fromJson(json);
    } while (cube.isNotOk);
    return cube;
  }

  static List<int> _getCornerOrientations() {
    List<int> co;
    do {
      co = List.generate(8, (_) => Random().nextInt(3));
    } while (co.sum % 3 != 0);
    return co;
  }

  static List<int> _getEdgeOrientations() {
    List<int> eo;
    do {
      eo = List.generate(12, (_) => Random().nextInt(2));
    } while (eo.sum % 2 != 0);
    return eo;
  }
}
