abstract class Stat implements Comparable<Stat> {
  int? get value;
  String get displayedName;
  String get displayedValue;

  @override
  String toString() {
    final name = displayedName;
    final score = displayedValue;
    return '$name: $score';
  }

  @override
  int compareTo(Stat other) {
    if (value == null && other.value == null) return 0;
    if (value == null) return -1;
    if (other.value == null) return 1;
    return other.value! - value!;
  }

  bool operator <(Stat other) {
    return compareTo(other) < 0;
  }

  bool operator <=(Stat other) {
    return compareTo(other) <= 0;
  }

  bool operator >(Stat other) {
    return compareTo(other) > 0;
  }

  bool operator >=(Stat other) {
    return compareTo(other) >= 0;
  }
}
