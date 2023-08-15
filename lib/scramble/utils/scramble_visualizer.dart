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

  static double spaceSize = 2;
  static double largeSpaceSize = 3;

  static Widget getLoadingCube() {
    final cubeSquares = List.generate(54, (_) => CubeSquare(grey));
    return _getCube(cubeSquares, 'scrambleVisualizationLoading');
  }

  static Widget getCube(String scramble) {
    final cube = Cube.getScrambledCube(scramble);
    final cubeSquares = _getSquares(cube.colors);
    return _getCube(cubeSquares, 'scrambleVisualizationLoaded');
  }

  static Widget getUpFace(String scramble) {
    final cube = Cube.getScrambledCube(scramble);
    if (cube.isSolved) _getErrorFace();
    final upFaceColors = cube.colors.sublist(0, 9).toList();
    final upFaceSquares = _getSquares(upFaceColors, isLarge: true);
    return _getFace(upFaceSquares, isLarge: true);
  }

  static Widget _getErrorFace() {
    final upFaceSquares =
        List.generate(9, (_) => CubeSquare(grey, isLarge: true));
    return _getFace(upFaceSquares, isLarge: true);
  }

  static Widget _getCube(List<CubeSquare> cubeSquares, String key) {
    final upFaceSquares = cubeSquares.sublist(0, 9).toList();
    final rightFaceSquares = cubeSquares.sublist(9, 18).toList();
    final frontFaceSquares = cubeSquares.sublist(18, 27).toList();
    final downFaceSquares = cubeSquares.sublist(27, 36).toList();
    final leftFaceSquares = cubeSquares.sublist(36, 45).toList();
    final bottomFaceSquares = cubeSquares.sublist(45, 54).toList();
    return Row(
      key: Key(key),
      children: [
        _getFace(leftFaceSquares),
        const SizedBox(width: 4),
        Column(
          children: [
            _getFace(upFaceSquares),
            const SizedBox(height: 4),
            _getFace(frontFaceSquares),
            const SizedBox(height: 4),
            _getFace(downFaceSquares),
          ],
        ),
        const SizedBox(width: 4),
        _getFace(rightFaceSquares),
        const SizedBox(width: 4),
        _getFace(bottomFaceSquares),
      ],
    );
  }

  static Widget _getFace(List<CubeSquare> faceSquares, {bool isLarge = false}) {
    final spaceBetween = isLarge ? largeSpaceSize : spaceSize;
    return Column(
      children: [
        _getRow(faceSquares.sublist(0, 3), isLarge: isLarge),
        SizedBox(height: spaceBetween),
        _getRow(faceSquares.sublist(3, 6), isLarge: isLarge),
        SizedBox(height: spaceBetween),
        _getRow(faceSquares.sublist(6, 9), isLarge: isLarge),
      ],
    );
  }

  static Widget _getRow(List<CubeSquare> rowSquares, {bool isLarge = false}) {
    final spaceBetween = isLarge ? largeSpaceSize : spaceSize;
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
    List<cube.Color> colors, {
    bool isLarge = false,
  }) {
    return colors.map((c) => _getSquare(c, isLarge: isLarge)).toList();
  }

  static CubeSquare _getSquare(cube.Color color, {bool isLarge = false}) {
    final boxColor = switch (color) {
      cube.Color.up => white,
      cube.Color.down => yellow,
      cube.Color.front => green,
      cube.Color.bottom => blue,
      cube.Color.right => red,
      cube.Color.left => orange,
    };
    return CubeSquare(boxColor, isLarge: isLarge);
  }
}

class CubeSquare extends StatelessWidget {
  const CubeSquare(this.color, {this.isLarge = false, super.key});

  static double squareSize = 8;
  static double largeSquareSize = 12;
  static double borderRadius = 2;
  static double largeBorderRadius = 3;

  final Color color;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final boxSize = isLarge ? largeSquareSize : squareSize;
    final boxBorderRadius = isLarge ? largeBorderRadius : borderRadius;
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
