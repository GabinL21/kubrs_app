import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/stats/model/best_stat.dart';

void main() {
  group('BestStat', () {
    test('displays empty best value correctly', () {
      final emptyBest = BestStat.empty();
      expect(emptyBest.displayedValue, '-');
    });

    test('displays DNF best value correctly', () {
      final dnfBest = BestStat.dnf();
      expect(dnfBest.displayedValue, 'DNF');
    });

    test('displays best value nearest to be rounded down correctly', () {
      final best = BestStat(10004);
      expect(best.displayedValue, '10.00');
    });

    test('displays best value nearest to be rounded up correctly', () {
      final best = BestStat(9995);
      expect(best.displayedValue, '09.99');
    });
  });
}
