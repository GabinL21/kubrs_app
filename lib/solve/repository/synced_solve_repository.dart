import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class SyncedSolveRepository extends SolveRepository {
  SyncedSolveRepository({required this.solveRepository});

  static const Duration onlineSaveDebounceTime = Duration(seconds: 1);
  final SolveRepository solveRepository;
  bool _listeningToSolvesUpdateStream = false;

  Future<void> saveOnline(Solve solve);
  Future<List<Solve>> fetch({required DateTime lastUpdate});

  Future<void> update() async {
    final lastUpdate = await solveRepository.getLastUpdate();
    final newSolves = await fetch(lastUpdate: lastUpdate);
    newSolves.forEach(solveRepository.save);
  }

  @override
  Future<void> save(Solve solve) async {
    if (!_listeningToSolvesUpdateStream) _listenToSolvesUpdateStream();
    await solveRepository.save(solve);
  }

  @override
  Future<List<Solve>> readSince(DateTime dateTime) async {
    await update();
    return solveRepository.readSince(dateTime);
  }

  @override
  Future<List<Solve>> readLast(int n, {bool withDnf = true}) async {
    await update();
    return solveRepository.readLast(n, withDnf: withDnf);
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

  @override
  Future<int> getSolveCount() async {
    await update();
    return solveRepository.getSolveCount();
  }

  void _listenToSolvesUpdateStream() {
    _listeningToSolvesUpdateStream = true;
    solveRepository
        .getUpdateStream()
        .groupBy((solve) => solve.timestamp)
        .flatMap((group) => group.debounceTime(onlineSaveDebounceTime))
        .listen(saveOnline);
  }
}
