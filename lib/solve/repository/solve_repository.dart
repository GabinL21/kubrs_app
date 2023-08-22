import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveRepository {
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _solvesCollection = FirebaseFirestore.instance.collection('solves');

  Future<void> addSolve(Solve solve) async {
    await _solvesCollection.add(solve.toJson());
  }

  Future<List<Solve>> getLastSolves() async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();
    return snapshot.docs.map((doc) => Solve.fromJson(doc.data())).toList();
  }

  Future<List<Solve>> getSolvesSince(
    DateTime dateTime, {
    bool offline = false,
  }) async {
    final source = offline ? Source.cache : Source.serverAndCache;
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .endAt([dateTime]).get(GetOptions(source: source));
    return snapshot.docs.map((doc) => Solve.fromJson(doc.data())).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamOfSolvesSince(
    DateTime dateTime,
  ) {
    return _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .endAt([dateTime]).snapshots();
  }

  Future<void> updateSolve(Solve updatedSolve) async {
    final lastSolveDocId = await _getSolveDocumentId(updatedSolve.timestamp);
    if (lastSolveDocId == null) return;
    await _solvesCollection.doc(lastSolveDocId).set(updatedSolve.toJson());
  }

  Future<void> deleteSolve(Solve solve) async {
    final lastSolveDocId = await _getSolveDocumentId(solve.timestamp);
    if (lastSolveDocId == null) return;
    await _solvesCollection.doc(lastSolveDocId).delete();
  }

  Future<String?> _getSolveDocumentId(DateTime solveTimestamp) async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .where('timestamp', isEqualTo: solveTimestamp)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs.first.id;
  }
}
