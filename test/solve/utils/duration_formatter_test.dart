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

    test('formats duration nearest to be rounded down correctly', () {
      const duration = Duration(milliseconds: 10004);
      expect(DurationFormatter.format(duration), equals('10.00'));
    });

    test('formats duration nearest to be rounded up correctly', () {
      const duration = Duration(milliseconds: 9995);
      expect(DurationFormatter.format(duration), equals('09.99'));
    });

    test('compact formats duration less than 1 second correctly', () {
      const duration = Duration(milliseconds: 500);
      expect(DurationFormatter.compactFormat(duration), equals('0s'));
    });

    test('compact formats duration less than 1 minute correctly', () {
      const duration = Duration(seconds: 30, milliseconds: 500);
      expect(DurationFormatter.compactFormat(duration), equals('30s'));
    });

    test('compact formats duration less than 1 hour correctly', () {
      const duration = Duration(minutes: 30, seconds: 25);
      expect(DurationFormatter.compactFormat(duration), equals('30m'));
    });

    test('compact formats duration greater than 1 hour correctly', () {
      const duration = Duration(hours: 15, minutes: 25);
      expect(DurationFormatter.compactFormat(duration), equals('15h'));
    });

    test('compact formats duration greater than 24 hours correctly', () {
      const duration = Duration(hours: 30, minutes: 25);
      expect(DurationFormatter.compactFormat(duration), equals('30h'));
    });

    test('compact formats duration of 1 second correctly', () {
      const duration = Duration(seconds: 1);
      expect(DurationFormatter.compactFormat(duration), equals('1s'));
    });

    test('compact formats duration of 1 minute correctly', () {
      const duration = Duration(minutes: 1);
      expect(DurationFormatter.compactFormat(duration), equals('1m'));
    });

    test('compact formats duration of 1 hour correctly', () {
      const duration = Duration(hours: 1);
      expect(DurationFormatter.compactFormat(duration), equals('1h'));
    });
  });
}
