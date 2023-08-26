import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/cache/repository/cache_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveRepository {
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _solvesCollection = FirebaseFirestore.instance.collection('solves');
  final _cacheRepository = CacheRepository();

  Future<void> addSolve(Solve solve) async {
    if (await _getSolveDocumentId(solve.timestamp) != null) {
      return; // The solve is already stored, cancel operation
    }
    await _solvesCollection.add(solve.toJsonWithUid(_uid));
    await _cacheRepository.writeSolve(solve);
  }

  Future<List<Solve>> getSolvesSince(
    DateTime dateTime, {
    bool offline = false,
  }) async {
    final source = offline ? Source.cache : Source.serverAndCache;
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .where('deleted', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .endAt([dateTime]).get(GetOptions(source: source));
    return snapshot.docs.map((doc) => Solve.fromJson(doc.data())).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSolvesStream() {
    return _solvesCollection
        .where('uid', isEqualTo: _uid)
        .where('deleted', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSolvesStreamSince(
    DateTime dateTime,
  ) {
    return _solvesCollection
        .where('uid', isEqualTo: _uid)
        .where('deleted', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .endAt([dateTime]).snapshots();
  }

  Future<void> updateSolve(Solve updatedSolve) async {
    final lastSolveDocId = await _getSolveDocumentId(updatedSolve.timestamp);
    if (lastSolveDocId == null) return;
    await _solvesCollection
        .doc(lastSolveDocId)
        .set(updatedSolve.toJsonWithUid(_uid));
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
