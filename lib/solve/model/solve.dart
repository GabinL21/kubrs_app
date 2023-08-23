import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/solve/utils/duration_formatter.dart';

class Solve extends Equatable {
  const Solve({
    required this.uid,
    required this.timestamp,
    required this.time,
    required this.scramble,
    this.plusTwo = false,
    this.dnf = false,
  });

  factory Solve.create({
    required DateTime timestamp,
    required Duration time,
    required String scramble,
    bool plusTwo = false,
    bool dnf = false,
  }) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Solve(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
      plusTwo: plusTwo,
      dnf: dnf,
    );
  }

  factory Solve.createNow({required Duration time, required String scramble}) {
    final timestamp = DateTime.now();
    return Solve.create(
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
    );
  }

  factory Solve.cloneAndToggleDNF({required Solve solve}) {
    return Solve(
      uid: solve.uid,
      timestamp: solve.timestamp,
      time: solve.time,
      scramble: solve.scramble,
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
    };
  }

  @override
  List<Object?> get props {
    return [uid, scramble, timestamp.millisecondsSinceEpoch, plusTwo, dnf];
  }
}
