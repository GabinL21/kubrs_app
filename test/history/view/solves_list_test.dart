import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/history/bloc/history_bloc.dart';
import 'package:kubrs_app/history/view/solve_tile.dart';
import 'package:kubrs_app/history/view/solves_list.dart';
import 'package:kubrs_app/solve/model/solve.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryBloc extends MockBloc<HistoryEvent, HistoryState>
    implements HistoryBloc {}

extension on WidgetTester {
  Future<void> pumpSolvesList(HistoryBloc historyBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: historyBloc,
          child: const Scaffold(
            body: SolvesList(),
          ),
        ),
      ),
    );
  }
}

void main() {
  final mockSolves = List.generate(
    3,
    (_) => Solve.create(
      uid: '',
      timestamp: DateTime(2000),
      time: const Duration(seconds: 10),
      scramble: 'R',
    ),
  );

  final mockExtraSolves = List.generate(
    10,
    (_) => Solve.create(
      uid: '',
      timestamp: DateTime(2000),
      time: const Duration(seconds: 10),
      scramble: 'R',
    ),
  );

  late HistoryBloc historyBloc;

  setUp(() {
    historyBloc = MockHistoryBloc();
  });

  group('SolvesList', () {
    testWidgets(
        'renders CircularProgressIndicator when history state is initial',
        (tester) async {
      when(() => historyBloc.state).thenReturn(HistoryInitial());
      await tester.pumpSolvesList(historyBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders CircularProgressIndicator when history state is loading',
        (tester) async {
      when(() => historyBloc.state).thenReturn(HistoryLoading());
      await tester.pumpSolvesList(historyBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders no solves text when history state is loaded and empty',
        (tester) async {
      when(() => historyBloc.state).thenReturn(HistoryLoaded(List.empty()));
      await tester.pumpSolvesList(historyBloc);
      expect(find.text('No solves'), findsOneWidget);
    });

    testWidgets('renders solve tiles when history state is loaded',
        (tester) async {
      when(() => historyBloc.state).thenReturn(HistoryLoaded(mockSolves));
      await tester.pumpSolvesList(historyBloc);
      expect(find.byType(SolveTile), findsNWidgets(mockSolves.length));
    });

    testWidgets('fetches first solves when history state is initial',
        (tester) async {
      when(() => historyBloc.state).thenReturn(HistoryInitial());
      await tester.pumpSolvesList(historyBloc);
      verify(() => historyBloc.add(const GetFirstHistory())).called(1);
    });

    testWidgets('fetches more solves when scrolled to the bottom',
        (tester) async {
      when(() => historyBloc.state).thenReturn(HistoryLoaded(mockExtraSolves));
      await tester.pumpSolvesList(historyBloc);
      await tester.drag(find.byType(SolvesList), const Offset(0, -2000));
      verify(() => historyBloc.add(const GetNextHistory())).called(1);
    });

    testWidgets(
        'fetches no solves '
        'when scrolled to the bottom and history is fully loaded',
        (tester) async {
      when(() => historyBloc.state)
          .thenReturn(HistoryFullyLoaded(mockExtraSolves));
      await tester.pumpSolvesList(historyBloc);
      await tester.drag(find.byType(SolvesList), const Offset(0, -2000));
      verifyNever(() => historyBloc.add(const GetNextHistory()));
    });
  });
}
