import 'package:clock/clock.dart';

class DateTimeFormatter {
  static String format(DateTime dateTime) {
    final now = clock.now();
    final duration = now.difference(dateTime);
    final years = duration.inDays ~/ 365;
    if (years != 0) return '$years year${_unitSuffix(years)} ago';
    final months = duration.inDays ~/ 30;
    if (months != 0) return '$months month${_unitSuffix(months)} ago';
    final weeks = duration.inDays ~/ 7;
    if (weeks != 0) return '$weeks week${_unitSuffix(weeks)} ago';
    final days = duration.inDays;
    if (days != 0) return '$days day${_unitSuffix(days)} ago';
    final hours = duration.inHours;
    if (hours != 0) return '$hours hour${_unitSuffix(hours)} ago';
    final minutes = duration.inMinutes;
    if (minutes != 0) return '$minutes minute${_unitSuffix(minutes)} ago';
    final seconds = duration.inSeconds;
    if (seconds != 0) return '$seconds second${_unitSuffix(seconds)} ago';
    return 'now';
  }

  static String _unitSuffix(int quantity) {
    return quantity > 1 ? 's' : '';
  }
}
