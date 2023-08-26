import 'package:bloc/bloc.dart';
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
      final solves = await historyRepository.getFirstHistory();
      emit(HistoryLoaded(solves));
    });
    on<GetNextHistory>((_, emit) async {
      if (state is! HistoryLoaded) return;
      final solves = state.solves;
      if (solves.isEmpty) {
        emit(HistoryFullyLoaded(solves));
        return;
      }
      emit(HistoryLoadingNext(solves));
      final newSolves = await historyRepository.getNextHistory(solves.last);
      if (newSolves.isEmpty) {
        emit(HistoryFullyLoaded(solves));
        return;
      }
      emit(HistoryLoaded(solves..addAll(newSolves)));
    });
    on<RefreshHistory>((_, emit) {
      emit(HistoryInitial());
    });
  }

  final HistoryRepository historyRepository;
  final SolveRepository solveRepository;
}
