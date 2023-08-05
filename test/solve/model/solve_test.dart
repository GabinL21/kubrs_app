import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/solve/model/solve.dart';

final _currentDateTime = DateTime(2000);

void main() {
  final solve = Solve(
    uid: '',
    timestamp: DateTime(2000),
    time: const Duration(seconds: 10),
    scramble: '',
  );
  group('Solve', () {
    test('returns correct effective time without +2', () {
      expect(solve.getEffectiveTime(), const Duration(seconds: 10));
    });

    test('returns correct effective time with +2', () {
      final plusTwoSolve = Solve.cloneAndTogglePlusTwo(solve: solve);
      expect(plusTwoSolve.getEffectiveTime(), const Duration(seconds: 12));
    });

    test('returns correct time to display without +2', () {
      expect(solve.getTimeToDisplay(), '10.00');
    });

    test('returns correct time to display with +2', () {
      final plusTwoSolve = Solve.cloneAndTogglePlusTwo(solve: solve);
      expect(plusTwoSolve.getTimeToDisplay(), '10.00+2');
    });

    test('returns correct time to display with DNF', () {
      final dnfSolve = Solve.cloneAndToggleDNF(solve: solve);
      expect(dnfSolve.getTimeToDisplay(), 'DNF');
    });
  });
}
