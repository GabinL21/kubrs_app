import 'package:cuber/cuber.dart' as cube;
import 'package:flutter/material.dart';

class ScrambleVisualizer {
  static Widget getLoadingCubeVisualization() {
    final cubeSquares = List.generate(54, (_) => const CubeSquare(Colors.grey));
    return _getCube(cubeSquares, 'scrambleVisualizationLoading');
  }

  static Widget getCubeVisualization(String scramble) {
    final cube = _getScrambledCube(scramble);
    final cubeSquares = cube.colors.map(_getSquare).toList();
    return _getCube(cubeSquares, 'scrambleVisualizationLoaded');
  }

  static Widget getUpFaceVisualization(String scramble) {
    final cube = _getScrambledCube(scramble);
    if (cube.isSolved) {
      // Scramble is empty or an error
      final upFaceSquares =
          List.generate(9, (_) => const CubeSquare(Colors.grey, isLarge: true));
      return _getFace(upFaceSquares, isLarge: true);
    }
    final upFaceColors = cube.colors.sublist(0, 9).toList();
    final upFaceSquares =
        upFaceColors.map((c) => _getSquare(c, isLarge: true)).toList();
    return _getFace(upFaceSquares, isLarge: true);
  }

  static cube.Cube _getScrambledCube(String scramble) {
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
    final spaceBetween = isLarge ? 3.0 : 2.0;
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
    final spaceBetween = isLarge ? 3.0 : 2.0;
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

  static CubeSquare _getSquare(cube.Color color, {bool isLarge = false}) {
    final boxColor = switch (color) {
      cube.Color.up => Colors.white,
      cube.Color.down => Colors.yellow,
      cube.Color.front => Colors.green,
      cube.Color.bottom => Colors.blue,
      cube.Color.right => Colors.red,
      cube.Color.left => Colors.orange,
    };
    return CubeSquare(boxColor, isLarge: isLarge);
  }
}

class CubeSquare extends StatelessWidget {
  const CubeSquare(this.color, {this.isLarge = false, super.key});

  final Color color;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final boxSize = isLarge ? 12.0 : 8.0;
    final borderRadius = isLarge ? 3.0 : 2.0;
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
