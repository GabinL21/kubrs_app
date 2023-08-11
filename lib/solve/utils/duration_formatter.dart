class DurationFormatter {
  static String format(Duration duration) {
    final roundedDuration = _roundDuration(duration);
    final minutesStr = roundedDuration.inMinutes.toString();
    final secondsStr =
        roundedDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final millisecondsStr =
        (roundedDuration.inMilliseconds.remainder(1000) / 10)
            .round()
            .toString()
            .padLeft(2, '0');
    var textStr = '$secondsStr.$millisecondsStr';
    if (duration >= const Duration(minutes: 1)) {
      textStr = '$minutesStr:$textStr';
    }
    return textStr;
  }

  static Duration _roundDuration(Duration duration) {
    final milliseconds = duration.inMilliseconds;
    final roundedMilliseconds = (milliseconds / 10).round() * 10;
    return Duration(milliseconds: roundedMilliseconds);
  }
}
