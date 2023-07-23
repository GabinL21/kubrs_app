part of 'solve_bloc.dart';

abstract class SolveState extends Equatable {
  const SolveState();

  @override
  List<Object> get props => [];
}

class SolveInitial extends SolveState {}

class SolveDone extends SolveState {
  const SolveDone(this.solve);

  final Solve solve;

  @override
  List<Object> get props => [solve];
}
