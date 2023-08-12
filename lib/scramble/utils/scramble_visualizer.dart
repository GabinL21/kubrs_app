import 'package:cuber/cuber.dart';
import 'package:flutter/material.dart';

class ScrambleVisualizer {
  static Widget getCubeVisualization(String scramble) {
    final cube = _getScrambledCube(scramble);
    final upFaceColors = cube.colors.sublist(0, 9).toList();
    final rightFaceColors = cube.colors.sublist(9, 18).toList();
    final frontFaceColors = cube.colors.sublist(18, 27).toList();
    final downFaceColors = cube.colors.sublist(27, 36).toList();
    final leftFaceColors = cube.colors.sublist(36, 45).toList();
    final bottomFaceColors = cube.colors.sublist(45, 54).toList();
    return Row(
      children: [
        _getFace(leftFaceColors),
        const SizedBox(width: 4),
        Column(
          children: [
            _getFace(upFaceColors),
            const SizedBox(height: 4),
            _getFace(frontFaceColors),
            const SizedBox(height: 4),
            _getFace(downFaceColors),
          ],
        ),
        const SizedBox(width: 4),
        _getFace(rightFaceColors),
        const SizedBox(width: 4),
        _getFace(bottomFaceColors),
      ],
    );
  }

  static Cube _getScrambledCube(String scramble) {
    final moves = _getMovesFromScramble(scramble);
    var cube = Cube.solved;
    for (final move in moves) {
      cube = cube.move(move);
    }
    return cube;
  }

  static List<Move> _getMovesFromScramble(String scramble) {
    return scramble.split(' ').map(Move.parse).toList();
  }

  static Widget _getFace(List<Color> faceColors) {
    return Column(
      children: [
        _getRow(faceColors.sublist(0, 3)),
        const SizedBox(height: 2),
        _getRow(faceColors.sublist(3, 6)),
        const SizedBox(height: 2),
        _getRow(faceColors.sublist(6, 9)),
      ],
    );
  }

  static Widget _getRow(List<Color> rowColors) {
    return Row(
      children: [
        _getSquare(rowColors[0]),
        const SizedBox(width: 2),
        _getSquare(rowColors[1]),
        const SizedBox(width: 2),
        _getSquare(rowColors[2]),
      ],
    );
  }

  static Widget _getSquare(Color color) {
    final boxColor = switch (color) {
      Color.up => Colors.white,
      Color.down => Colors.yellow,
      Color.front => Colors.green,
      Color.bottom => Colors.blue,
      Color.right => Colors.red,
      Color.left => Colors.orange,
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
