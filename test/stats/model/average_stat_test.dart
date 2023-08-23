import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/stats/model/average_stat.dart';

void main() {
  group('AverageStat', () {
    test('displays empty average value correctly', () {
      final emptyAverage = AverageStat.empty(5);
      expect(emptyAverage.displayedValue, '-');
    });

    test('displays DNF average value correctly', () {
      final dnfAverage = AverageStat.dnf(5);
      expect(dnfAverage.displayedValue, 'DNF');
    });

    test('displays average value nearest to be rounded down correctly', () {
      final average = AverageStat(10004, 5);
      expect(average.displayedValue, '10.00');
    });

    test('displays average value nearest to be rounded up correctly', () {
      final average = AverageStat(9995, 5);
      expect(average.displayedValue, '09.99');
    });
  });
}
