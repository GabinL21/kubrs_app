part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState(this.solvesByTimestamp);

  final Map<int, Solve> solvesByTimestamp;

  List<Solve> get solves => solvesByTimestamp.values.toList();

  @override
  List<Object> get props => [solvesByTimestamp];
}

class SessionInitial extends SessionState {
  SessionInitial() : super({});
}

class SessionLoaded extends SessionState {
  const SessionLoaded(super.solvesByTimestamp);
}
