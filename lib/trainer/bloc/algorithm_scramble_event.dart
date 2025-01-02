part of 'algorithm_scramble_bloc.dart';

abstract class AlgorithmScrambleEvent extends Equatable {
  const AlgorithmScrambleEvent();

  @override
  List<Object> get props => [];
}

class GenerateAlgorithmScrambleEvent extends AlgorithmScrambleEvent {
  const GenerateAlgorithmScrambleEvent({required this.algorithm});

  final Algorithm algorithm;
}
