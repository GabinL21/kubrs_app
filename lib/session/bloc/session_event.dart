part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class AddSessionSolve extends SessionEvent {
  const AddSessionSolve(this.solve);

  final Solve solve;
}
