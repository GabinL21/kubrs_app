class DurationFormatter {
  static String format(Duration duration) {
    final minutesStr = duration.inMinutes.toString();
    final secondsStr =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final millisecondsStr = (duration.inMilliseconds.remainder(1000) / 10)
        .floor()
        .toString()
        .padLeft(2, '0');
    var textStr = '$secondsStr.$millisecondsStr';
    if (duration >= const Duration(minutes: 1)) {
      textStr = '$minutesStr:$textStr';
    }
    return textStr;
  }

  static String compactFormat(Duration duration) {
    if (duration.inMinutes == 0) return '${duration.inSeconds}s';
    if (duration.inHours == 0) return '${duration.inMinutes}m';
    return '${duration.inHours}h';
  }
}
