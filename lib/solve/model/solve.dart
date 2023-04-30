import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Solve {
  Solve({
    required this.uid,
    required this.timestamp,
    required this.time,
    required this.scramble,
  });

  factory Solve.create({required Duration time, required String scramble}) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final timestamp = DateTime.now();
    return Solve(
      uid: uid,
      timestamp: timestamp,
      time: time,
      scramble: scramble,
    );
  }

  factory Solve.fromJson(Map<String, dynamic> map) {
    return Solve(
      uid: map['uid'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      time: Duration(milliseconds: map['time'] as int),
      scramble: map['scramble'] as String,
    );
  }

  final String uid;
  final DateTime timestamp;
  final Duration time;
  final String scramble;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'timestamp': timestamp,
      'time': time.inMilliseconds,
      'scramble': scramble,
    };
  }
}
