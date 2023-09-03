import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(this.solveRepository) : super(StatsInitial()) {
    on<LoadLastSolvesStats>((event, emit) async {
      emit(StatsLoading());
      final solves = await solveRepository.readLast(event.n, withDnf: false);
      final reversedSolves = solves.reversed.toList();
      emit(StatsLoaded(reversedSolves));
    });
  }

  final SolveRepository solveRepository;
}
