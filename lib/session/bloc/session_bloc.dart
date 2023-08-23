import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({required this.solveBloc, required this.solveRepository})
      : super(SessionInitial()) {
    solveRepository
        .getSolvesStreamSince(sessionStart)
        .listen((_) => add(const RefreshSessionSolves()));
    on<RefreshSessionSolves>((event, emit) async {
      emit(SessionLoading(state.solves));
      final sessionSolves = await solveRepository.getSolvesSince(
        sessionStart,
        offline: true, // Limit Firestore server calls
      );
      emit(SessionLoaded(sessionSolves));
    });
  }
  final SolveBloc solveBloc;
  final SolveRepository solveRepository;
  final DateTime sessionStart = DateTime.now();
}
