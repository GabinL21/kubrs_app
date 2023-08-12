import 'package:cuber/cuber.dart';
import 'package:flutter/material.dart';

class ScrambleVisualizer {
  static Widget getLoadingCubeVisualization() {
    final cubeColors = List.generate(54, (_) => Color.up);
    return _getCube(cubeColors);
  }

  static Widget getCubeVisualization(String scramble) {
    final cube = _getScrambledCube(scramble);
    return _getCube(cube.colors);
  }

  static Widget getUpFaceVisualization(String scramble) {
    final cube = _getScrambledCube(scramble);
    final upFaceColors = cube.colors.sublist(0, 9).toList();
    return _getFace(upFaceColors, isLarge: true);
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

  static Widget _getCube(List<Color> cubeColors) {
    final upFaceColors = cubeColors.sublist(0, 9).toList();
    final rightFaceColors = cubeColors.sublist(9, 18).toList();
    final frontFaceColors = cubeColors.sublist(18, 27).toList();
    final downFaceColors = cubeColors.sublist(27, 36).toList();
    final leftFaceColors = cubeColors.sublist(36, 45).toList();
    final bottomFaceColors = cubeColors.sublist(45, 54).toList();
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

  static Widget _getFace(List<Color> faceColors, {bool isLarge = false}) {
    final spaceBetween = isLarge ? 3.0 : 2.0;
    return Column(
      children: [
        _getRow(faceColors.sublist(0, 3), isLarge: isLarge),
        SizedBox(height: spaceBetween),
        _getRow(faceColors.sublist(3, 6), isLarge: isLarge),
        SizedBox(height: spaceBetween),
        _getRow(faceColors.sublist(6, 9), isLarge: isLarge),
      ],
    );
  }

  static Widget _getRow(List<Color> rowColors, {bool isLarge = false}) {
    final spaceBetween = isLarge ? 3.0 : 2.0;
    return Row(
      children: [
        _getSquare(rowColors[0], isLarge: isLarge),
        SizedBox(width: spaceBetween),
        _getSquare(rowColors[1], isLarge: isLarge),
        SizedBox(width: spaceBetween),
        _getSquare(rowColors[2], isLarge: isLarge),
      ],
    );
  }

  static Widget _getSquare(Color color, {bool isLarge = false}) {
    final boxSize = isLarge ? 12.0 : 8.0;
    final borderRadius = isLarge ? 3.0 : 2.0;
    final boxColor = switch (color) {
      Color.up => Colors.white,
      Color.down => Colors.yellow,
      Color.front => Colors.green,
      Color.bottom => Colors.blue,
      Color.right => Colors.red,
      Color.left => Colors.orange,
    };
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

extension CubeColor on Color {}
