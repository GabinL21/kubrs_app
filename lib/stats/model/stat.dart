abstract class Stat {
  String getDisplayedName();
  String getDisplayedScore();

  @override
  String toString() {
    final name = getDisplayedName();
    final score = getDisplayedScore();
    return '$name: $score';
  }
}
