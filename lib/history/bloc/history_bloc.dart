import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.historyRepository, required this.solveRepository})
      : super(HistoryInitial()) {
    solveRepository
        .getSolvesStream()
        .listen((_) => add(const RefreshHistory()));
    on<GetFirstHistory>((_, emit) async {
      if (state is! HistoryInitial) return;
      emit(HistoryLoading());
      final history = await historyRepository.getFirstHistory();
      emit(HistoryLoaded(history.solves, history.lastDocument));
    });
    on<GetNextHistory>((_, emit) async {
      if (state is! HistoryLoaded) return;
      if (state.lastDocument == null) return;
      final lastDocument = (state as HistoryLoaded).lastDocument;
      final solves = state.solves;
      final nbSolves = solves.length;
      emit(HistoryLoadingNext(solves));
      final newHistory =
          await historyRepository.getNextHistory(state.solves, lastDocument!);
      if (nbSolves == newHistory.solves.length) {
        emit(HistoryFullyLoaded(solves, lastDocument));
        return;
      }
      emit(HistoryLoaded(newHistory.solves, newHistory.lastDocument));
    });
    on<RefreshHistory>((_, emit) {
      emit(HistoryInitial());
    });
  }

  final HistoryRepository historyRepository;
  final SolveRepository solveRepository;
}
