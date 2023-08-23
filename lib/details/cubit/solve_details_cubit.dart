import 'package:bloc/bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsCubit extends Cubit<Solve> {
  SolveDetailsCubit(super.solve);

  void togglePlusTwo() {
    emit(Solve.cloneAndTogglePlusTwo(solve: state));
  }

  void toggleDnf() {
    emit(Solve.cloneAndToggleDNF(solve: state));
  }
}
