import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

class Solve extends Equatable {
  const Solve({
    required this.uid,
    required this.timestamp,
    required this.time,
    required this.scramble,
    this.plusTwo = false,
    this.dnf = false,
    required this.lastUpdate,
  });

  factory Solve.create({
    required String uid,
    required DateTime timestamp,
    required Duration time,
    required String scramble,
    bool plusTwo = false,
    bool dnf = false,
  }) {
    return Solve(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
      plusTwo: plusTwo,
      dnf: dnf,
      lastUpdate: timestamp,
    );
  }

  factory Solve.createNow({
    required String uid,
    required Duration time,
    required String scramble,
  }) {
    final timestamp = DateTime.now();
    return Solve.create(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
    );
  }

  factory Solve.cloneAndTogglePlusTwo({required Solve solve}) {
    return Solve(
      uid: solve.uid,
      timestamp: solve.timestamp,
      time: solve.time,
      scramble: solve.scramble,
      plusTwo: !solve.plusTwo,
      lastUpdate: solve.lastUpdate,
    );
  }

  factory Solve.cloneAndToggleDNF({required Solve solve}) {
    return Solve(
      uid: solve.uid,
      timestamp: solve.timestamp,
      time: solve.time,
      scramble: solve.scramble,
      dnf: !solve.dnf,
      lastUpdate: solve.lastUpdate,
    );
  }

  factory Solve.fromJson(Map<String, dynamic> map) {
    return Solve(
      uid: map['uid'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      time: Duration(milliseconds: map['time'] as int),
      scramble: map['scramble'] as String,
      plusTwo: (map['plusTwo'] ?? false) as bool,
      dnf: (map['dnf'] ?? false) as bool,
      lastUpdate:
          ((map['lastUpdate'] ?? map['timestamp']) as Timestamp).toDate(),
    );
  }

  static const Duration plusTwoDuration = Duration(seconds: 2);
  final String uid;
  final DateTime timestamp;
  final Duration time;
  final String scramble;
  final bool plusTwo;
  final bool dnf;
  final DateTime lastUpdate;

  Duration get effectiveTime {
    if (dnf) return const Duration(minutes: 10);
    if (plusTwo) return time + plusTwoDuration;
    return time;
  }

  String get timeToDisplay {
    if (dnf) return 'DNF';
    final formattedTime = DurationFormatter.format(time);
    if (plusTwo) return '$formattedTime+2';
    return formattedTime;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'timestamp': timestamp,
      'time': time.inMilliseconds,
      'scramble': scramble,
      'plusTwo': plusTwo,
      'dnf': dnf,
      'lastUpdate': lastUpdate,
    };
  }

  @override
  List<Object?> get props {
    return [
      uid,
      scramble,
      timestamp.millisecondsSinceEpoch,
      plusTwo,
      dnf,
      lastUpdate.millisecondsSinceEpoch,
    ];
  }
}
