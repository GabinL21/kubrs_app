part of 'solve_bloc.dart';

abstract class SolveEvent extends Equatable {
  const SolveEvent();

  @override
  List<Object> get props => [];
}

class AddSolve extends SolveEvent {
  const AddSolve({required this.solve});

  final Solve solve;
}

class ToggleDNFTag extends SolveEvent {
  const ToggleDNFTag({required this.solve});

  final Solve solve;
}

class GetSolves extends SolveEvent {}
