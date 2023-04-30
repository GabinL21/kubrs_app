import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveRepository {
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _solvesCollection = FirebaseFirestore.instance.collection('solves');

  Future<void> addSolve(Solve solve) async {
    await _solvesCollection.add(solve.toJson());
  }

  Future<List<Solve>> getLastFiveSolves() async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .limit(5)
        .get();
    return snapshot.docs.map((doc) => Solve.fromJson(doc.data())).toList();
  }
}
