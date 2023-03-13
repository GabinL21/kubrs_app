part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  AuthError(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
