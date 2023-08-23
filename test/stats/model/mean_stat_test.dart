import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/stats/model/mean_stat.dart';

void main() {
  group('MeanStat', () {
    test('displays empty mean value correctly', () {
      final emptyMean = MeanStat.empty(5);
      expect(emptyMean.displayedValue, '-');
    });

    test('displays DNF mean value correctly', () {
      final dnfMean = MeanStat.dnf(5);
      expect(dnfMean.displayedValue, 'DNF');
    });

    test('displays mean value nearest to be rounded down correctly', () {
      final mean = MeanStat(10004, 5);
      expect(mean.displayedValue, '10.00');
    });

    test('displays mean value nearest to be rounded up correctly', () {
      final mean = MeanStat(9995, 5);
      expect(mean.displayedValue, '09.99');
    });
  });
}
