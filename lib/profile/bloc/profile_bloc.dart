import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.solveRepository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      final solveCount = await solveRepository.getSolveCount();
      final totalSolveTime = await solveRepository.getTotalSolveTime();
      emit(
        ProfileLoaded(
          solveCount: solveCount,
          totalSolveTime: totalSolveTime,
        ),
      );
    });
  }

  final SolveRepository solveRepository;
}
