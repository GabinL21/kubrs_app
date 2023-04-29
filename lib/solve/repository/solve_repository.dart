import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addSolve(Solve solve) async {
    await _firestore.collection('solves').add(solve.toMap());
  }
}
