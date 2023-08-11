part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState(this.solves);

  final List<Solve> solves;

  @override
  List<Object> get props => [solves];
}

class SessionInitial extends SessionState {
  SessionInitial() : super(List.empty());
}

class SessionLoading extends SessionState {
  const SessionLoading(super.solves);
}

class SessionLoaded extends SessionState {
  const SessionLoaded(super.solves);
}
