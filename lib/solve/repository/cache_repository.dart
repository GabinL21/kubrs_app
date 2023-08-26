import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:sqflite/sqflite.dart';

class CacheRepository {
  static const dbCreationQuery = '''
    CREATE TABLE solves(
      timestamp INTEGER PRIMARY KEY, 
      time INTEGER, 
      scramble TEXT,
      plus_two INTEGER,
      dnf INTEGER,
      last_update INTEGER,
      deleted INTEGER
    );
    ''';

  final futureDb = openDatabase(
    'kubrs.db',
    onCreate: (db, _) {
      return db.execute(
        dbCreationQuery,
      );
    },
    version: 1,
  );

  Future<void> writeSolve(Solve solve) async {
    final db = await futureDb;
    final solveData = _getSolveData(solve);
    await db.insert(
      'solves',
      solveData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Solve>> readFirstSolvesPage(int size) async {
    await _syncCacheOnline();
    final db = await futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      where: 'deleted = 0',
      orderBy: 'timestamp DESC',
      limit: size,
    );
    return solvesData.map(_getSolveFromData).toList();
  }

  Future<List<Solve>> readSolvesPage(int size, DateTime lastTimestamp) async {
    final db = await futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      where: 'timestamp < ? AND deleted = 0',
      whereArgs: [lastTimestamp.millisecondsSinceEpoch],
      orderBy: 'timestamp DESC',
      limit: size,
    );
    return solvesData.map(_getSolveFromData).toList();
  }

  Future<void> _syncCacheOnline() async {
    final lastUpdate = await _getLastUpdate();
    final newSolves = await _getOnlineSolvesSince(lastUpdate);
    newSolves.forEach(writeSolve);
  }

  Future<int> _getLastUpdate() async {
    final db = await futureDb;
    final List<Map<String, dynamic>> data = await db.query('solves');
    if (data.isEmpty) return 0;
    return data[0]['last_update'] as int;
  }

  Future<List<Solve>> _getOnlineSolvesSince(int lastUpdate) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('solves')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('deleted', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .endAt([lastUpdate]).get();
    return snapshot.docs.map((doc) => Solve.fromJson(doc.data())).toList();
  }

  Map<String, dynamic> _getSolveData(Solve solve) {
    return {
      'timestamp': solve.timestamp.millisecondsSinceEpoch,
      'time': solve.time.inMilliseconds,
      'scramble': solve.scramble,
      'plus_two': solve.plusTwo ? 1 : 0,
      'dnf': solve.dnf ? 1 : 0,
      'last_update': solve.lastUpdate.millisecondsSinceEpoch,
      'deleted': solve.deleted ? 1 : 0,
    };
  }

  Solve _getSolveFromData(Map<String, dynamic> solveData) {
    return Solve(
      timestamp:
          DateTime.fromMillisecondsSinceEpoch(solveData['timestamp'] as int),
      time: Duration(milliseconds: solveData['time'] as int),
      scramble: solveData['scramble'] as String,
      plusTwo: solveData['plus_two'] as int == 1,
      dnf: solveData['dnf'] as int == 1,
      lastUpdate:
          DateTime.fromMillisecondsSinceEpoch(solveData['last_update'] as int),
      deleted: solveData['deleted'] as int == 1,
    );
  }
}
