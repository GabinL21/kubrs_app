part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserRequested extends UserEvent {}

class UserSolve extends UserEvent {
  UserSolve({required this.solve});

  final Solve solve;
}
