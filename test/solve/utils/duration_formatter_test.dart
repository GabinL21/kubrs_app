import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

void main() {
  group('DurationFormatter', () {
    test('formats duration less than 1 minute correctly', () {
      const duration = Duration(seconds: 30, milliseconds: 500);
      expect(DurationFormatter.format(duration), equals('30.50'));
    });

    test('formats duration greater than 1 minute correctly', () {
      const duration = Duration(minutes: 1, seconds: 30, milliseconds: 500);
      expect(DurationFormatter.format(duration), equals('1:30.50'));
    });

    test('formats duration greater than 10 minutes correctly', () {
      const duration = Duration(minutes: 10, seconds: 30, milliseconds: 500);
      expect(DurationFormatter.format(duration), equals('10:30.50'));
    });

    test('formats duration less than 1 second correctly', () {
      const duration = Duration(milliseconds: 500);
      expect(DurationFormatter.format(duration), equals('00.50'));
    });

    test('formats duration of 1 second correctly', () {
      const duration = Duration(seconds: 1);
      expect(DurationFormatter.format(duration), equals('01.00'));
    });

    test('formats duration of 1 minute correctly', () {
      const duration = Duration(minutes: 1);
      expect(DurationFormatter.format(duration), equals('1:00.00'));
    });

    test('formats duration of 1 hour correctly', () {
      const duration = Duration(hours: 1);
      expect(DurationFormatter.format(duration), equals('60:00.00'));
    });

    test('formats duration rounded down correctly', () {
      const duration = Duration(milliseconds: 10004);
      expect(DurationFormatter.format(duration), equals('10.00'));
    });

    test('formats duration rounded up correctly', () {
      const duration = Duration(milliseconds: 9995);
      expect(DurationFormatter.format(duration), equals('10.00'));
    });
  });
}
