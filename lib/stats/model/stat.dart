abstract class Stat {
  String getDisplayedName();
  String getDisplayedValue();

  @override
  String toString() {
    final name = getDisplayedName();
    final score = getDisplayedValue();
    return '$name: $score';
  }
}
