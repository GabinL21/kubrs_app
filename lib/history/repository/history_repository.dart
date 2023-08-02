import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/history/model/history.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class HistoryRepository {
  static const int pageSize = 20;
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final _solvesCollection = FirebaseFirestore.instance.collection('solves');

  Future<History> getFirstHistory() async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .limit(pageSize)
        .get();
    final docs = snapshot.docs;
    final solves = docs.map((doc) => Solve.fromJson(doc.data())).toList();
    final lastDocument = docs.isNotEmpty ? docs.last : null;
    return History(solves, lastDocument);
  }

  Future<History> getNextHistory(
    List<Solve> solves,
    DocumentSnapshot lastDocument,
  ) async {
    final snapshot = await _solvesCollection
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true)
        .startAfterDocument(lastDocument)
        .limit(pageSize)
        .get();
    final docs = snapshot.docs;
    final nextSolves = docs.map((doc) => Solve.fromJson(doc.data())).toList();
    final newLastDocument = docs.isNotEmpty ? docs.last : lastDocument;
    return History(solves..addAll(nextSolves), newLastDocument);
  }
}
