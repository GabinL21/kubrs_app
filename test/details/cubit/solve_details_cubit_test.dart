import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/details/cubit/solve_details_cubit.dart';
import 'package:kubrs_app/solve/model/solve.dart';

void main() {
  group('SolveDetailsCubit', () {
    final mockSolve = Solve(
      uid: '',
      timestamp: DateTime(2000),
      time: const Duration(seconds: 10),
      scramble: '',
      lastUpdate: DateTime(2000),
    );

    blocTest<SolveDetailsCubit, Solve>(
      'emits solve when solve details cubit is created',
      build: () => SolveDetailsCubit(mockSolve),
      verify: (cubit) => cubit.state == mockSolve,
    );

    blocTest<SolveDetailsCubit, Solve>(
      'emits solve with toggled +2 when +2 is toggled',
      build: () => SolveDetailsCubit(mockSolve),
      act: (cubit) => cubit.togglePlusTwo(),
      expect: () => <Solve>[Solve.cloneAndTogglePlusTwo(solve: mockSolve)],
    );

    blocTest<SolveDetailsCubit, Solve>(
      'emits solve with toggled DNF when DNF is toggled',
      build: () => SolveDetailsCubit(mockSolve),
      act: (cubit) => cubit.toggleDnf(),
      expect: () => <Solve>[Solve.cloneAndToggleDNF(solve: mockSolve)],
    );
  });
}
