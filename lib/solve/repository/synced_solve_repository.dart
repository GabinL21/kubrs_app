import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';

abstract class SyncedSolveRepository extends SolveRepository {
  SyncedSolveRepository({required this.solveRepository});

  final SolveRepository solveRepository;

  Future<void> saveOnline(Solve solve);
  Future<List<Solve>> fetch({required DateTime lastUpdate});

  Future<void> update() async {
    final lastUpdate = await solveRepository.getLastUpdate();
    final newSolves = await fetch(lastUpdate: lastUpdate);
    newSolves.forEach(solveRepository.save);
  }

  @override
  Future<void> save(Solve solve) async {
    await solveRepository.save(solve);
    await saveOnline(solve);
  }

  @override
  Future<List<Solve>> readSince(DateTime dateTime) async {
    await update();
    return solveRepository.readSince(dateTime);
  }

  @override
  Future<List<Solve>> readFirstHistoryPage({required int pageSize}) async {
    await update();
    return solveRepository.readFirstHistoryPage(pageSize: pageSize);
  }

  @override
  Future<List<Solve>> readNextHistoryPage({
    required int pageSize,
    required Solve lastSolve,
  }) {
    return solveRepository.readNextHistoryPage(
      pageSize: pageSize,
      lastSolve: lastSolve,
    );
  }

  @override
  Stream<Solve> getUpdateStream() {
    return solveRepository.getUpdateStream();
  }

  @override
  Future<DateTime> getLastUpdate() {
    return solveRepository.getLastUpdate();
  }
}