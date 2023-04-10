import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/user/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UserRequested>((event, emit) async {
      emit(UserLoading());
      try {
        final userName = await userRepository.getUserName();
        emit(UserLoaded(userName));
      } catch (e) {
        emit(UserError('An error occurred: $e'));
      }
    });
  }
  final UserRepository userRepository;
}
