import 'package:firebase_auth/firebase_auth.dart';

class Solve {
  Solve({
    required this.time,
    required this.scramble,
  })  : uid = FirebaseAuth.instance.currentUser!.uid,
        timestamp = DateTime.now();

  final String uid;
  final DateTime timestamp;
  final Duration time;
  final String scramble;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'timestamp': timestamp,
      'time': time.inMilliseconds,
      'scramble': scramble,
    };
  }
}
