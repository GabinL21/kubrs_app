part of 'scramble_bloc.dart';

abstract class ScrambleEvent extends Equatable {
  const ScrambleEvent();

  @override
  List<Object> get props => [];
}

class GenerateScrambleEvent extends ScrambleEvent {}
