import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

class Solve {
  Solve({
    required this.uid,
    required this.timestamp,
    required this.time,
    required this.scramble,
    required this.plusTwo,
    required this.dnf,
  });

  factory Solve.create({required Duration time, required String scramble}) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final timestamp = DateTime.now();
    return Solve(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
      plusTwo: false,
      dnf: false,
    );
  }

  factory Solve.cloneAndTogglePlusTwo({required Solve solve}) {
    return Solve(
      uid: solve.uid,
      timestamp: solve.timestamp,
      time: solve.time,
      scramble: solve.scramble,
      plusTwo: !solve.plusTwo,
      dnf: false,
    );
  }

  factory Solve.cloneAndToggleDNF({required Solve solve}) {
    return Solve(
      uid: solve.uid,
      timestamp: solve.timestamp,
      time: solve.time,
      scramble: solve.scramble,
      plusTwo: false,
      dnf: !solve.dnf,
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
    );
  }

  static const Duration plusTwoDuration = Duration(seconds: 2);
  final String uid;
  final DateTime timestamp;
  final Duration time;
  final String scramble;
  final bool plusTwo;
  final bool dnf;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'timestamp': timestamp,
      'time': time.inMilliseconds,
      'scramble': scramble,
      'plusTwo': plusTwo,
      'dnf': dnf,
    };
  }

  Duration getEffectiveTime() {
    if (plusTwo) return time + plusTwoDuration;
    return time;
  }

  String getTimeToDisplay() {
    if (dnf) return 'DNF';
    final formattedTime = DurationFormatter.format(time);
    if (plusTwo) return '$formattedTime+2';
    return formattedTime;
  }
}
