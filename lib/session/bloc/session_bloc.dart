import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.solveRepository,
  }) : super(SessionInitial()) {
    solveRepository.getUpdateStream().listen(
          (solve) => {
            if (solve.timestamp.isAfter(sessionStart))
              add(const RefreshSessionSolves()),
          },
        );
    on<RefreshSessionSolves>((event, emit) async {
      emit(SessionLoading(state.solves));
      final sessionSolves = await solveRepository.readSince(sessionStart);
      emit(SessionLoaded(sessionSolves));
    });
  }
  final SolveRepository solveRepository;
  final DateTime sessionStart = DateTime.now();
}
