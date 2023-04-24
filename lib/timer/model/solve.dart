import 'package:firebase_auth/firebase_auth.dart';

class Solve {
  Solve({
    required this.time,
  })  : uid = FirebaseAuth.instance.currentUser!.uid,
        timestamp = DateTime.now();

  final String uid;
  final Duration time;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'time': time.inMilliseconds,
      'timestamp': timestamp,
    };
  }
}
