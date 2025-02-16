import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';

class CubePattern extends Equatable {
  const CubePattern({
    required this.uFace,
    required this.bSide,
    required this.lSide,
    required this.rSide,
    required this.fSide,
  });

  Cube toCube() {
    const uFaceDef = 'UUUUUUUUU';
    final bFaceDef = 'BBBBBB${_digitListToDefinition(bSide)}';
    final lFaceDef = 'LLLLLL${_digitListToDefinition(lSide)}';
    final rFaceDef = 'RRRRRR${_digitListToDefinition(rSide)}';
    final fFaceDef = 'FFFFFF${_digitListToDefinition(fSide)}';
    final dFaceDef = _digitListToDefinition(uFace);
    final cubeDefinition =
        uFaceDef + rFaceDef + fFaceDef + dFaceDef + lFaceDef + bFaceDef;
    return Cube.from(cubeDefinition);
  }

  String _digitListToDefinition(List<int> digitList) {
    return digitList.map(_digitToDefinition).join();
  }

  String _digitToDefinition(int digit) {
    switch (digit) {
      case 1:
        return 'U';
      case 2:
        return 'D';
      case 3:
        return 'F';
      case 4:
        return 'B';
      case 5:
        return 'R';
      case 6:
        return 'L';
      default:
        throw ArgumentError('Invalid digit: $digit');
    }
  }

  final List<int> uFace;
  final List<int> bSide;
  final List<int> lSide;
  final List<int> rSide;
  final List<int> fSide;

  @override
  List<Object?> get props {
    return [uFace, bSide, lSide, rSide, fSide];
  }
}
