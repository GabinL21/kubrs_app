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
    _listenToSolvesUpdateStream();
    on<AddSessionSolve>((event, emit) async {
      final solve = event.solve;
      final timestamp = solve.timestamp.millisecondsSinceEpoch;
      final solvesByTimestamp = state.solvesByTimestamp;
      if (solve.deleted) {
        solvesByTimestamp.remove(timestamp);
      } else {
        solvesByTimestamp[timestamp] = solve;
      }
      emit(SessionLoaded(solvesByTimestamp));
    });
  }

  final SolveRepository solveRepository;
  final DateTime sessionStart = DateTime.now();

  void _listenToSolvesUpdateStream() {
    solveRepository.getUpdateStream().listen(
          (solve) => {
            if (solve.timestamp.isAfter(sessionStart))
              add(AddSessionSolve(solve)),
          },
        );
  }
}
