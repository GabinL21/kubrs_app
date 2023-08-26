import 'package:kubrs_app/cache/repository/cache_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class HistoryRepository {
  static const int pageSize = 10;
  final _cacheRepository = CacheRepository();

  Future<List<Solve>> getFirstHistory() {
    return _cacheRepository.readFirstSolvesPage(pageSize);
  }

  Future<List<Solve>> getNextHistory(Solve lastSolve) async {
    return _cacheRepository.readSolvesPage(pageSize, lastSolve.timestamp);
  }
}
