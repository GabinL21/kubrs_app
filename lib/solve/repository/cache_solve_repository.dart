import 'dart:async';

import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:sqflite/sqflite.dart';

class CacheSolveRepository extends SolveRepository {
  static const _dbCreationQuery = '''
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

  final _futureDb = openDatabase(
    'kubrs.db',
    onCreate: (db, _) {
      return db.execute(
        _dbCreationQuery,
      );
    },
    version: 1,
  );

  final StreamController<Solve> _solvesUpdateStreamController =
      StreamController<Solve>.broadcast();

  @override
  Future<void> save(Solve solve) async {
    _solvesUpdateStreamController.add(solve);
    final db = await _futureDb;
    final solveData = _getSolveData(solve);
    await db.insert(
      'solves',
      solveData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Solve>> readSince(DateTime dateTime) async {
    final db = await _futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      where: 'timestamp >= ? AND deleted = 0',
      whereArgs: [dateTime.millisecondsSinceEpoch],
      orderBy: 'timestamp DESC',
    );
    return solvesData.map(_getSolveFromData).toList();
  }

  @override
  Future<List<Solve>> readLast(int n, {bool withDnf = true}) async {
    final db = await _futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      where: withDnf ? 'deleted = 0' : 'deleted = 0 AND dnf = 0',
      orderBy: 'timestamp DESC',
      limit: n,
    );
    return solvesData.map(_getSolveFromData).toList();
  }

  @override
  Future<List<Solve>> readFirstHistoryPage({required int pageSize}) async {
    final db = await _futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      where: 'deleted = 0',
      orderBy: 'timestamp DESC',
      limit: pageSize,
    );
    return solvesData.map(_getSolveFromData).toList();
  }

  @override
  Future<List<Solve>> readNextHistoryPage({
    required int pageSize,
    required Solve lastSolve,
  }) async {
    final db = await _futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      where: 'timestamp < ? AND deleted = 0',
      whereArgs: [lastSolve.timestamp.millisecondsSinceEpoch],
      orderBy: 'timestamp DESC',
      limit: pageSize,
    );
    return solvesData.map(_getSolveFromData).toList();
  }

  @override
  Stream<Solve> getUpdateStream() {
    return _solvesUpdateStreamController.stream;
  }

  @override
  Future<DateTime> getLastUpdate() async {
    final db = await _futureDb;
    final List<Map<String, dynamic>> solvesData = await db.query(
      'solves',
      orderBy: 'last_update DESC',
      limit: 1,
    );
    final lastUpdateInMillis =
        solvesData.isEmpty ? 0 : solvesData.first['last_update'] as int;
    return DateTime.fromMillisecondsSinceEpoch(lastUpdateInMillis);
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
