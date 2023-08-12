part of 'scramble_bloc.dart';

abstract class ScrambleState extends Equatable {
  const ScrambleState(this.scramble);

  final String scramble;

  @override
  List<Object> get props => [scramble];
}

class ScrambleInitial extends ScrambleState {
  const ScrambleInitial() : super('');
}

class ScrambleLoading extends ScrambleState {
  const ScrambleLoading() : super('');
}

class ScrambleLoaded extends ScrambleState {
  const ScrambleLoaded(super.scramble);
}
