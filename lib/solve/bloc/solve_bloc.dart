import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

part 'solve_event.dart';
part 'solve_state.dart';

class SolveBloc extends Bloc<SolveEvent, SolveState> {
  SolveBloc({required this.solveRepository}) : super(SolveInitial()) {
    on<ResetSolve>((_, emit) async {
      emit(SolveInitial());
    });
    on<AddSolve>((event, emit) async {
      final solve = event.solve;
      emit(SolveDone(solve));
      await solveRepository.addSolve(solve);
    });
    on<ToggleDNFTag>((event, emit) async {
      final solve = event.solve;
      final newSolve = Solve.cloneAndToggleDNF(solve: solve);
      emit(SolveDone(newSolve));
      await solveRepository.updateLastSolve(newSolve);
    });
  }
  final SolveRepository solveRepository;
}
