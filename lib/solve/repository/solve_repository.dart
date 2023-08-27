import 'package:kubrs_app/solve/model/solve.dart';

abstract class SolveRepository {
  Future<void> save(Solve solve);

  Future<List<Solve>> readSince(DateTime dateTime);

  Future<List<Solve>> readFirstHistoryPage({required int pageSize});

  Future<List<Solve>> readNextHistoryPage({
    required int pageSize,
    required Solve lastSolve,
  });

  Stream<Solve> getUpdateStream();

  Future<DateTime> getLastUpdate();
}
