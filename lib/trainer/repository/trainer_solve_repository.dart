import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

class TrainerSolveRepository extends SolveRepository {
  @override
  Future<void> save(Solve solve) async {}

  @override
  Future<List<Solve>> readSince(DateTime dateTime) async {
    return List.empty();
  }

  @override
  Future<List<Solve>> readLast(int n, {bool withDnf = true}) async {
    return List.empty();
  }

  @override
  Future<List<Solve>> readFirstHistoryPage({required int pageSize}) async {
    return List.empty();
  }

  @override
  Future<List<Solve>> readNextHistoryPage({
    required int pageSize,
    required Solve lastSolve,
  }) async {
    return List.empty();
  }

  @override
  Future<int> getSolveCount() async {
    return 0;
  }

  @override
  Future<int> getTotalSolveTime() async {
    return 0;
  }

  @override
  Stream<Solve> getUpdateStream() {
    return const Stream.empty();
  }

  @override
  Future<DateTime> getLastUpdate() async {
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
