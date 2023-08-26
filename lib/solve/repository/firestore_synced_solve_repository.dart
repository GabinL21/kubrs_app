import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/synced_solve_repository.dart';

class FirestoreSyncedSolveRepository extends SyncedSolveRepository {
  FirestoreSyncedSolveRepository({required super.solveRepository});

  final _uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  final _solvesCollection = FirebaseFirestore.instance.collection('solves');

  @override
  Future<List<Solve>> fetch({required DateTime lastUpdate}) async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .endBefore([lastUpdate]).get();
    return snapshot.docs.map((doc) => Solve.fromJson(doc.data())).toList();
  }

  @override
  Future<void> saveOnline(Solve solve) async {
    final solveData = solve.toJsonWithUid(_uid);
    final solveDocId = await _getSolveDocId(solve);
    await _solvesCollection.doc(solveDocId).set(solveData);
  }

  Future<String?> _getSolveDocId(Solve solve) async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .where('timestamp', isEqualTo: solve.timestamp)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs.first.id;
  }
}
