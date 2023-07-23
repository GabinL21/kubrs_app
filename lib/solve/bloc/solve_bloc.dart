import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'solve_event.dart';
part 'solve_state.dart';

class SolveBloc extends Bloc<SolveEvent, SolveState> {
  SolveBloc({required this.solveRepository}) : super(SolveInitial()) {
    on<AddSolve>((event, _) async {
      final solve = event.solve;
      await solveRepository.addSolve(solve);
    });
    on<GetSolves>((_, emit) async {
      emit(SolveLoading());
      final solves = await solveRepository.getLastSolves();
      emit(SolveLoaded(solves));
    });
    on<ToggleDNFTag>((_, emit) async {});
  }
  final SolveRepository solveRepository;
}
