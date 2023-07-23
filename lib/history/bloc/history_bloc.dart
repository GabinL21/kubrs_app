import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.historyRepository}) : super(HistoryInitial()) {
    on<GetHistory>((_, emit) async {
      emit(HistoryLoading());
      final solves = await historyRepository.getLastTenSolves();
      emit(HistoryLoaded(solves));
    });
  }
  final HistoryRepository historyRepository;
}
