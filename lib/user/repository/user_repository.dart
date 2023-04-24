import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/timer/model/solve.dart';

class UserRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> getUserName() async {
    final user = _auth.currentUser;
    if (user == null) return 'Error';
    final uid = user.uid;
    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (!userDoc.exists) return 'Error';
    final userData = userDoc.data();
    if (userData == null) return 'Error';
    final userName = userData['name'];
    return userName as String;
  }

  Future<void> storeSolve(Solve solve) async {
    await _firestore.collection('solves').add(solve.toMap());
  }
}
