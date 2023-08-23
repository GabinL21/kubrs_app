part of 'solve_bloc.dart';

abstract class SolveEvent extends Equatable {
  const SolveEvent();

  @override
  List<Object> get props => [];
}

class ResetSolve extends SolveEvent {
  const ResetSolve();
}

class EndSolve extends SolveEvent {
  const EndSolve({required this.solve});

  final Solve solve;
}

class TogglePlusTwoTag extends SolveEvent {
  const TogglePlusTwoTag({required this.solve});

  final Solve solve;
}

class ToggleDNFTag extends SolveEvent {
  const ToggleDNFTag({required this.solve});

  final Solve solve;
}

class DeleteSolve extends SolveEvent {
  const DeleteSolve({required this.solve});

  final Solve solve;
}
