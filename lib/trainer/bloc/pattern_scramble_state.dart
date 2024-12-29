part of 'pattern_scramble_bloc.dart';

abstract class PatternScrambleState extends Equatable {
  const PatternScrambleState(this.scramble);

  final String scramble;

  @override
  List<Object> get props => [scramble];
}

class PatternScrambleInitial extends PatternScrambleState {
  const PatternScrambleInitial() : super('');
}

class PatternScrambleLoading extends PatternScrambleState {
  const PatternScrambleLoading() : super('');
}

class PatternScrambleLoaded extends PatternScrambleState {
  const PatternScrambleLoaded(super.scramble);
}
