import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/solve/model/solve.dart';

void main() {
  final solve = Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: const Duration(seconds: 10),
    scramble: '',
  );

  final roundedDownSolve = Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: const Duration(milliseconds: 10004),
    scramble: '',
  );

  final roundedUpSolve = Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: const Duration(milliseconds: 9995),
    scramble: '',
  );

  group('Solve', () {
    test('returns correct effective time without +2', () {
      expect(solve.effectiveTime, const Duration(seconds: 10));
    });

    test('returns correct effective time with +2', () {
      final plusTwoSolve = Solve.cloneAndTogglePlusTwo(solve: solve);
      expect(plusTwoSolve.effectiveTime, const Duration(seconds: 12));
    });

    test('returns correct time to display nearest to be rounded down', () {
      expect(roundedDownSolve.timeToDisplay, '10.00');
    });

    test('returns correct time to display nearest to be rounded up', () {
      expect(roundedUpSolve.timeToDisplay, '09.99');
    });

    test('returns correct time to display without +2', () {
      expect(solve.timeToDisplay, '10.00');
    });

    test('returns correct time to display with +2', () {
      final plusTwoSolve = Solve.cloneAndTogglePlusTwo(solve: solve);
      expect(plusTwoSolve.timeToDisplay, '10.00+2');
    });

    test('returns correct time to display with DNF', () {
      final dnfSolve = Solve.cloneAndToggleDNF(solve: solve);
      expect(dnfSolve.timeToDisplay, 'DNF');
    });
  });
}
