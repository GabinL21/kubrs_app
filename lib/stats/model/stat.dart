abstract class Stat {
  String get displayedName;
  String get displayedValue;

  @override
  String toString() {
    final name = displayedName;
    final score = displayedValue;
    return '$name: $score';
  }
}
