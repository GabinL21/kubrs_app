import 'package:equatable/equatable.dart';

class CubePattern extends Equatable {
  const CubePattern({
    required this.uFace,
    required this.fSide,
    required this.rSide,
    required this.bSide,
    required this.lSide,
  });

  final List<int> uFace;
  final List<int> fSide;
  final List<int> rSide;
  final List<int> bSide;
  final List<int> lSide;

  @override
  List<Object?> get props {
    return [uFace, fSide, rSide, bSide, lSide];
  }
}
