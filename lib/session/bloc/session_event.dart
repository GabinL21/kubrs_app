part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class SaveSessionSolve extends SessionEvent {
  const SaveSessionSolve(this.solve);

  final Solve solve;
}
