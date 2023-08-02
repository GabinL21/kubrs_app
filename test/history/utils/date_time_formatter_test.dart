import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/history/utils/date_time_formatter.dart';

final _currentDateTime = DateTime(2000);

void main() {
  group('DateTimeFormatter', () {
    test('formats now correctly', () {
      final dateTime = _currentDateTime;
      expect(_format(dateTime), equals('now'));
    });

    test('formats 1 second ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(seconds: 1));
      expect(_format(dateTime), equals('1 second ago'));
    });

    test('formats 10 seconds ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(seconds: 10));
      expect(_format(dateTime), equals('10 seconds ago'));
    });

    test('formats 1 minute ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(minutes: 1));
      expect(_format(dateTime), equals('1 minute ago'));
    });

    test('formats 10 minutes ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(minutes: 10));
      expect(_format(dateTime), equals('10 minutes ago'));
    });

    test('formats 1 hour ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(hours: 1));
      expect(_format(dateTime), equals('1 hour ago'));
    });

    test('formats 10 hours ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(hours: 10));
      expect(_format(dateTime), equals('10 hours ago'));
    });

    test('formats 1 day ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 1));
      expect(_format(dateTime), equals('1 day ago'));
    });

    test('formats 2 days ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 2));
      expect(_format(dateTime), equals('2 days ago'));
    });

    test('formats 1 week ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 7));
      expect(_format(dateTime), equals('1 week ago'));
    });

    test('formats 2 weeks ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 14));
      expect(_format(dateTime), equals('2 weeks ago'));
    });

    test('formats 1 month ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 30));
      expect(_format(dateTime), equals('1 month ago'));
    });

    test('formats 2 months ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 60));
      expect(_format(dateTime), equals('2 months ago'));
    });

    test('formats 1 year ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 365));
      expect(_format(dateTime), equals('1 year ago'));
    });

    test('formats 2 years ago correctly', () {
      final dateTime = _currentDateTime.subtract(const Duration(days: 730));
      expect(_format(dateTime), equals('2 years ago'));
    });
  });
}

String _format(DateTime dateTime) {
  return withClock(
    Clock.fixed(_currentDateTime),
    () => DateTimeFormatter.format(dateTime),
  );
}
