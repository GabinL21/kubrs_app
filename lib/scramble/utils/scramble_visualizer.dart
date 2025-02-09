import 'package:cuber/cuber.dart' as cube;
import 'package:flutter/material.dart';
import 'package:kubrs_app/trainer/model/cube_pattern.dart';

class ScrambleVisualizer {

  ScrambleVisualizer.loading({this.size = 8}) {
    cubeSquares = List.generate(54, (_) => CubeSquare(color: grey, size: size));
  }

  ScrambleVisualizer.fromScramble({required String scramble, this.size = 8}) {
    final cube = Cube.getScrambledCube(scramble);
    cubeSquares = _getSquares(cube.colors, size);
  }

  ScrambleVisualizer.fromCubePattern({
    required CubePattern cubePattern,
    this.size = 8,
  }) {
    Color numberToColor(int number) {
      switch (number) {
        case 0:
          return grey;
        case 1:
          return white;
        case 2:
          return yellow;
        case 3:
          return green;
        case 4:
          return blue;
        case 5:
          return red;
        case 6:
          return orange;
        default:
          return grey;
      }
    }

    CubeSquare numberToCubeSquare(int number) {
      return CubeSquare(color: numberToColor(number), size: size);
    }

    // U Face
    cubeSquares += cubePattern.uFace.map(numberToCubeSquare).toList();
    // Fill other faces
    cubeSquares += List.generate(45, (_) => numberToCubeSquare(0));
    // R Face
    cubeSquares[9] = numberToCubeSquare(cubePattern.rSide[0]);
    cubeSquares[12] = numberToCubeSquare(cubePattern.rSide[1]);
    cubeSquares[15] = numberToCubeSquare(cubePattern.rSide[2]);
    // F Face
    cubeSquares[18] = numberToCubeSquare(cubePattern.fSide[0]);
    cubeSquares[19] = numberToCubeSquare(cubePattern.fSide[1]);
    cubeSquares[20] = numberToCubeSquare(cubePattern.fSide[2]);
    // L Face
    cubeSquares[38] = numberToCubeSquare(cubePattern.lSide[0]);
    cubeSquares[41] = numberToCubeSquare(cubePattern.lSide[1]);
    cubeSquares[44] = numberToCubeSquare(cubePattern.lSide[2]);
    // B Face
    cubeSquares[51] = numberToCubeSquare(cubePattern.bSide[0]);
    cubeSquares[52] = numberToCubeSquare(cubePattern.bSide[1]);
    cubeSquares[53] = numberToCubeSquare(cubePattern.bSide[2]);
  }

  static Color grey = const Color.fromRGBO(132, 132, 132, 1);
  static Color white = const Color.fromRGBO(223, 223, 223, 1);
  static Color yellow = const Color.fromRGBO(234, 237, 114, 1);
  static Color green = const Color.fromRGBO(131, 239, 114, 1);
  static Color blue = const Color.fromRGBO(88, 136, 229, 1);
  static Color red = const Color.fromRGBO(249, 82, 82, 1);
  static Color orange = const Color.fromRGBO(242, 146, 58, 1);

  List<CubeSquare> cubeSquares = [];
  final double size;

  Widget getCube() {
    final upFaceSquares = cubeSquares.sublist(0, 9).toList();
    final rightFaceSquares = cubeSquares.sublist(9, 18).toList();
    final frontFaceSquares = cubeSquares.sublist(18, 27).toList();
    final downFaceSquares = cubeSquares.sublist(27, 36).toList();
    final leftFaceSquares = cubeSquares.sublist(36, 45).toList();
    final backFaceSquares = cubeSquares.sublist(45, 54).toList();
    final space = 4 * size / 8;
    return Row(
      key: const Key('scrambleVisualizationLoaded'),
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
        _getFace(backFaceSquares, size),
      ],
    );
  }

  Widget getUpFace() {
    final upFaceSquares = cubeSquares.sublist(0, 9).toList();
    return _getFace(upFaceSquares, size);
  }

  Widget getUpFaceWithSides() {
    final space = 4 * size / 8;
    final upFaceSquares = cubeSquares.sublist(0, 9).toList();
    final rFaceUpSideSquares = [
      cubeSquares[9],
      cubeSquares[12],
      cubeSquares[15],
    ];
    cubeSquares.sublist(9, 12).toList();
    final fFaceUpSideSquares = cubeSquares.sublist(18, 21).toList();
    final lFaceUpSideSquares = [
      cubeSquares[38],
      cubeSquares[41],
      cubeSquares[44],
    ];
    final bFaceUpSideSquares = cubeSquares.sublist(51, 54).toList();
    return Row(
      key: const Key('scrambleVisualizationLoaded'),
      children: [
        _getColumn(lFaceUpSideSquares, space / 2),
        SizedBox(width: space),
        Column(
          children: [
            _getRow(bFaceUpSideSquares, space / 2),
            SizedBox(height: space),
            _getFace(upFaceSquares, size),
            SizedBox(height: space),
            _getRow(fFaceUpSideSquares, space / 2),
          ],
        ),
        SizedBox(width: space),
        _getColumn(rFaceUpSideSquares, space / 2),
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

  static Widget _getColumn(
      List<CubeSquare> columnSquares,
      double spaceBetween) {
    return Column(
      children: [
        columnSquares[0],
        SizedBox(height: spaceBetween),
        columnSquares[1],
        SizedBox(height: spaceBetween),
        columnSquares[2],
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
