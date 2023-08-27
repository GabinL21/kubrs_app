import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(this.solveRepository) : super(StatsInitial()) {
    on<LoadLastSevenDaysSolvesStats>((event, emit) async {
      emit(StatsLoading());
      final solves = await solveRepository
          .readSince(DateTime.now().subtract(const Duration(days: 7)));
      final reversedSolves = solves.reversed.toList();
      emit(StatsLoaded(reversedSolves));
    });
  }

  final SolveRepository solveRepository;
}
