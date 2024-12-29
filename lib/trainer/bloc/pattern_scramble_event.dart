part of 'pattern_scramble_bloc.dart';

abstract class PatternScrambleEvent extends Equatable {
  const PatternScrambleEvent();

  @override
  List<Object> get props => [];
}

class GeneratePatternScrambleEvent extends PatternScrambleEvent {
  const GeneratePatternScrambleEvent({required this.pattern});

  final CubePattern pattern;
}
