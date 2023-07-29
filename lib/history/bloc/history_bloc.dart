import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.historyRepository}) : super(HistoryInitial()) {
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
  }
  final HistoryRepository historyRepository;
}
