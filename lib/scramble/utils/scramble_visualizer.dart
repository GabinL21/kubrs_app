import 'package:cuber/cuber.dart' as cube;
import 'package:flutter/material.dart';

class ScrambleVisualizer {
  static Color grey = const Color.fromRGBO(132, 132, 132, 1);
  static Color white = const Color.fromRGBO(223, 223, 223, 1);
  static Color yellow = const Color.fromRGBO(234, 237, 114, 1);
  static Color green = const Color.fromRGBO(131, 239, 114, 1);
  static Color blue = const Color.fromRGBO(88, 136, 229, 1);
  static Color red = const Color.fromRGBO(249, 82, 82, 1);
  static Color orange = const Color.fromRGBO(242, 146, 58, 1);

  static Widget getLoadingCube({double size = 8}) {
    final cubeSquares =
        List.generate(54, (_) => CubeSquare(color: grey, size: size));
    return _getCube(
      cubeSquares: cubeSquares,
      key: 'scrambleVisualizationLoading',
    );
  }

  static Widget getCube({required String scramble, double size = 8}) {
    final cube = Cube.getScrambledCube(scramble);
    final cubeSquares = _getSquares(cube.colors, size);
    return _getCube(
      cubeSquares: cubeSquares,
      key: 'scrambleVisualizationLoaded',
    );
  }

  static Widget getUpFace({required String scramble, double size = 10}) {
    final cube = Cube.getScrambledCube(scramble);
    if (cube.isSolved) _getErrorFace();
    final upFaceColors = cube.colors.sublist(0, 9).toList();
    final upFaceSquares = _getSquares(upFaceColors, size);
    return _getFace(upFaceSquares, size);
  }

  static Widget _getErrorFace({double size = 10}) {
    final upFaceSquares =
        List.generate(9, (_) => CubeSquare(color: grey, size: size));
    return _getFace(upFaceSquares, size);
  }

  static Widget _getCube({
    required List<CubeSquare> cubeSquares,
    required String key,
    double size = 8,
  }) {
    final upFaceSquares = cubeSquares.sublist(0, 9).toList();
    final rightFaceSquares = cubeSquares.sublist(9, 18).toList();
    final frontFaceSquares = cubeSquares.sublist(18, 27).toList();
    final downFaceSquares = cubeSquares.sublist(27, 36).toList();
    final leftFaceSquares = cubeSquares.sublist(36, 45).toList();
    final bottomFaceSquares = cubeSquares.sublist(45, 54).toList();
    final space = 4 * size / 8;
    return Row(
      key: Key(key),
      children: [
        _getFace(leftFaceSquares, size),
        SizedBox(width: space),
        Column(
          children: [
            _getFace(upFaceSquares, size),
            SizedBox(height: space),
            _getFace(frontFaceSquares, size),
            SizedBox(height: space),
            _getFace(downFaceSquares, size),
          ],
        ),
        SizedBox(width: space),
        _getFace(rightFaceSquares, size),
        SizedBox(width: space),
        _getFace(bottomFaceSquares, size),
      ],
    );
  }

  static Widget _getFace(List<CubeSquare> faceSquares, double size) {
    final spaceBetween = 2 * size / 8;
    return Column(
      children: [
        _getRow(faceSquares.sublist(0, 3), spaceBetween),
        SizedBox(height: spaceBetween),
        _getRow(faceSquares.sublist(3, 6), spaceBetween),
        SizedBox(height: spaceBetween),
        _getRow(faceSquares.sublist(6, 9), spaceBetween),
      ],
    );
  }

  static Widget _getRow(List<CubeSquare> rowSquares, double spaceBetween) {
    return Row(
      children: [
        rowSquares[0],
        SizedBox(width: spaceBetween),
        rowSquares[1],
        SizedBox(width: spaceBetween),
        rowSquares[2],
      ],
    );
  }

  static List<CubeSquare> _getSquares(
    List<cube.Color> colors,
    double size,
  ) {
    return colors.map((c) => _getSquare(c, size)).toList();
  }

  static CubeSquare _getSquare(cube.Color color, double size) {
    final boxColor = switch (color) {
      cube.Color.up => white,
      cube.Color.down => yellow,
      cube.Color.front => green,
      cube.Color.bottom => blue,
      cube.Color.right => red,
      cube.Color.left => orange,
    };
    return CubeSquare(color: boxColor, size: size);
  }
}

class CubeSquare extends StatelessWidget {
  const CubeSquare({required this.color, required this.size, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final boxSize = size;
    final boxBorderRadius = 2 * size / 8;
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(boxBorderRadius),
      ),
    );
  }
}

extension Cube on cube.Cube {
  static cube.Cube getScrambledCube(String scramble) {
    final moves = _getMovesFromScramble(scramble);
    var scrambledCube = cube.Cube.solved;
    for (final move in moves) {
      scrambledCube = scrambledCube.move(move);
    }
    return scrambledCube;
  }

  static List<cube.Move> _getMovesFromScramble(String scramble) {
    try {
      return scramble.split(' ').map(cube.Move.parse).toList();
    } catch (e, _) {
      return List.empty(); // Return no moves when parsing fails
    }
  }
}
