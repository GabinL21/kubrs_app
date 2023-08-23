import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/stats/model/worst_stat.dart';

void main() {
  group('WorstStat', () {
    test('displays empty worst value correctly', () {
      final emptyWorst = WorstStat.empty();
      expect(emptyWorst.displayedValue, '-');
    });

    test('displays DNF worst value correctly', () {
      final dnfWorst = WorstStat.dnf();
      expect(dnfWorst.displayedValue, 'DNF');
    });

    test('displays worst value nearest to be rounded down correctly', () {
      final worst = WorstStat(10004);
      expect(worst.displayedValue, '10.00');
    });

    test('displays worst value nearest to be rounded up correctly', () {
      final worst = WorstStat(9995);
      expect(worst.displayedValue, '09.99');
    });
  });
}
