part of 'solve_bloc.dart';

abstract class SolveState extends Equatable {
  const SolveState();

  @override
  List<Object> get props => [];
}

class SolveInitial extends SolveState {}

class SolveLoading extends SolveState {}

class SolveLoaded extends SolveState {
  const SolveLoaded(this.solves);

  final List<Solve> solves;
}
