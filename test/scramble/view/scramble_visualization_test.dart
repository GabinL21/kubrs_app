import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/scramble/view/scramble_visualization.dart';
import 'package:mocktail/mocktail.dart';

class MockScrambleBloc extends MockBloc<ScrambleEvent, ScrambleState>
    implements ScrambleBloc {}

extension on WidgetTester {
  Future<void> pumpScrambleVisualization(ScrambleBloc scrambleBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: scrambleBloc,
          child: const ScrambleVisualization(),
        ),
      ),
    );
  }
}

void main() {
  const loadingKey = Key('scrambleVisualizationLoading');
  const loadedKey = Key('scrambleVisualizationLoaded');
  const scramble = "L U2 D R' F2 R2 L2 U R' F' D2 F2 D2 B U L2 B2";

  late ScrambleBloc scrambleBloc;

  setUp(() {
    scrambleBloc = MockScrambleBloc();
  });

  group('ScrambleVisualization', () {
    testWidgets(
        'renders loading cube visualization when scramble state is initial',
        (tester) async {
      when(() => scrambleBloc.state).thenReturn(const ScrambleInitial());
      await tester.pumpScrambleVisualization(scrambleBloc);
      expect(find.byKey(loadingKey), findsOneWidget);
    });

    testWidgets(
        'renders loading cube visualization when scramble state is loading',
        (tester) async {
      when(() => scrambleBloc.state).thenReturn(const ScrambleLoading());
      await tester.pumpScrambleVisualization(scrambleBloc);
      expect(find.byKey(loadingKey), findsOneWidget);
    });

    testWidgets('renders cube visualization when scramble state is loaded',
        (tester) async {
      when(() => scrambleBloc.state).thenReturn(const ScrambleLoaded(scramble));
      await tester.pumpScrambleVisualization(scrambleBloc);
      expect(find.byKey(loadedKey), findsOneWidget);
    });
  });
}
