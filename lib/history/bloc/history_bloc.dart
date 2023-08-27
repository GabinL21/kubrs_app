import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.solveRepository}) : super(HistoryInitial()) {
    solveRepository
        .getUpdateStream()
        .listen((_) => add(const RefreshHistory()));
    on<GetFirstHistory>((_, emit) async {
      if (state is! HistoryInitial) return;
      emit(HistoryLoading());
      final solves = await solveRepository.readFirstHistoryPage(
        pageSize: pageSize,
      );
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
      final newSolves = await solveRepository.readNextHistoryPage(
        pageSize: pageSize,
        lastSolve: solves.last,
      );
      if (newSolves.isEmpty) {
        emit(HistoryFullyLoaded(solves));
        return;
      }
      emit(HistoryLoaded(solves..addAll(newSolves)));
    });
    on<RefreshHistory>((_, emit) async {
      if (state is! HistoryLoaded && state is! HistoryFullyLoaded) return;
      emit(HistoryRefreshing(state.solves));
      final solves = await solveRepository.readFirstHistoryPage(
        pageSize: pageSize,
      );
      emit(HistoryLoaded(solves));
    });
  }

  static const int pageSize = 20;
  final SolveRepository solveRepository;
}
