import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

class MockSolveRepository extends Mock implements SolveRepository {}

void main() {
  group('HistoryBloc', () {
    final mockSolves = List.generate(
      3,
      (_) => Solve.create(
        timestamp: DateTime(2000),
        time: const Duration(seconds: 10),
        scramble: '',
      ),
    );

    late HistoryRepository historyRepository;
    late SolveRepository solveRepository;

    setUp(() {
      historyRepository = MockHistoryRepository();
      when(
        () => historyRepository.getFirstHistory(),
      ).thenAnswer((_) => Future.value(mockSolves));
      solveRepository = MockSolveRepository();
      when(
        () => solveRepository.getSolvesStream(),
      ).thenAnswer((_) => const Stream.empty());
    });

    blocTest<HistoryBloc, HistoryState>(
      'emits initial state when history is created',
      build: () => HistoryBloc(
        historyRepository: historyRepository,
        solveRepository: solveRepository,
      ),
      verify: (bloc) => bloc.state == HistoryInitial(),
    );

    blocTest<HistoryBloc, HistoryState>(
      'emits loading and loaded states when history is first fetched',
      build: () => HistoryBloc(
        historyRepository: historyRepository,
        solveRepository: solveRepository,
      ),
      act: (bloc) => bloc.add(const GetFirstHistory()),
      expect: () => <HistoryState>[HistoryLoading(), HistoryLoaded(mockSolves)],
    );

    blocTest<HistoryBloc, HistoryState>(
      'emits intial state when history is refreshed',
      build: () => HistoryBloc(
        historyRepository: historyRepository,
        solveRepository: solveRepository,
      ),
      seed: () => HistoryLoaded(mockSolves),
      act: (bloc) => bloc.add(const RefreshHistory()),
      expect: () => <HistoryState>[HistoryInitial()],
    );
  });
}
