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
    CREATE TABLE values(
      last_update INTEGER
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
    await db.insert('solves', solveData);
  }

  Future<List<Solve>> readSolves() async {
    final db = await futureDb;
    final List<Map<String, dynamic>> solvesData =
        await db.query('solves', orderBy: 'timestamp DESC');
    return solvesData.map(_getSolveFromData).toList();
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
      uid: '',
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
