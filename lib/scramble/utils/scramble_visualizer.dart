import 'package:cuber/cuber.dart';
import 'package:flutter/material.dart';

class ScrambleVisualizer {
  static Widget getCubeFace(String scramble) {
    final cube = _getScrambledCube(scramble);
    final frontFaceColors = cube.colors.take(9).toList();
    return _getFace(frontFaceColors);
  }

  static Cube _getScrambledCube(String scramble) {
    final moves = _getMovesFromScramble(scramble);
    final cube = Cube.scrambled(n: 0);
    for (final move in moves) {
      cube.move(move);
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
      _ => Colors.white,
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
