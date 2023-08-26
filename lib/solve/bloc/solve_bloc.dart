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
    on<EndSolve>((event, emit) async {
      final solve = event.solve;
      emit(SolveDone(solve));
      await solveRepository.save(solve);
    });
    on<TogglePlusTwoTag>((event, emit) async {
      final solve = event.solve;
      final newSolve = Solve.cloneAndTogglePlusTwo(solve: solve);
      if (state is SolveDone && event.solve == (state as SolveDone).solve) {
        // Update last solve if the last solve is being updated
        emit(SolveDone(newSolve));
      }
      await solveRepository.save(newSolve);
    });
    on<ToggleDNFTag>((event, emit) async {
      final solve = event.solve;
      final newSolve = Solve.cloneAndToggleDNF(solve: solve);
      if (state is SolveDone && event.solve == (state as SolveDone).solve) {
        // Update last solve if the last solve is being updated
        emit(SolveDone(newSolve));
      }
      await solveRepository.save(newSolve);
    });
    on<DeleteSolve>((event, emit) async {
      final solve = event.solve;
      final deletedSolve = Solve.cloneAndDelete(solve: solve);
      if (state is SolveDone && event.solve == (state as SolveDone).solve) {
        // Reset solve bloc if the last solve has been deleted
        emit(SolveInitial());
      }
      await solveRepository.save(deletedSolve);
    });
  }
  final SolveRepository solveRepository;
}
