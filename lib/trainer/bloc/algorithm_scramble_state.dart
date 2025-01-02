part of 'algorithm_scramble_bloc.dart';

abstract class AlgorithmScrambleState extends Equatable {
  const AlgorithmScrambleState(this.scramble);

  final String scramble;

  @override
  List<Object> get props => [scramble];
}

class AlgorithmScrambleInitial extends AlgorithmScrambleState {
  const AlgorithmScrambleInitial() : super('');
}

class AlgorithmScrambleLoading extends AlgorithmScrambleState {
  const AlgorithmScrambleLoading() : super('');
}

class AlgorithmScrambleLoaded extends AlgorithmScrambleState {
  const AlgorithmScrambleLoaded(super.scramble);
}
