import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/model/history.dart';
import 'package:kubrs_app/history/repository/history_repository.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  group('HistoryBloc', () {
    final mockSolves = List.generate(
      3,
      (_) => Solve(
        uid: '',
        timestamp: DateTime(2000),
        time: const Duration(seconds: 10),
        scramble: '',
      ),
    );

    late HistoryRepository historyRepository;

    setUp(() {
      historyRepository = MockHistoryRepository();
      when(
        () => historyRepository.getFirstHistory(),
      ).thenAnswer((_) => Future.value(History(mockSolves, null)));
    });

    blocTest<HistoryBloc, HistoryState>(
      'emits initial state when history is created',
      build: () => HistoryBloc(historyRepository: historyRepository),
      verify: (bloc) => bloc.state == HistoryInitial(),
    );

    blocTest<HistoryBloc, HistoryState>(
      'emits loading and loaded states when history is first fetched',
      build: () => HistoryBloc(historyRepository: historyRepository),
      act: (bloc) => bloc.add(const GetFirstHistory()),
      expect: () =>
          <HistoryState>[HistoryLoading(), HistoryLoaded(mockSolves, null)],
    );
  });
}
