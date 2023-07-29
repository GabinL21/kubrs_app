import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class History {
  History(this.solves, this.lastDocument);

  final List<Solve> solves;
  final DocumentSnapshot? lastDocument;
}
