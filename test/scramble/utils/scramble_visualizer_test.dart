import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';

extension on WidgetTester {
  Future<void> pumpVisualization(Widget visualization) {
    return pumpWidget(
      MaterialApp(
        home: visualization,
      ),
    );
  }
}

void main() {
  group('ScrambleVisualizer', () {
    const scramble = "L U2 D R' F2 R2 L2 U R' F' D2 F2 D2 B U L2 B2";
    const emptyScramble = '';
    const errorScramble = 'a b c d';

    testWidgets('displays 9 squares when visualizing up face', (tester) async {
      final visualization =
          ScrambleVisualizer.fromScramble(scramble: scramble).getUpFace();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(9));
    });

    testWidgets(
        'displays 9 squares when visualizing up face with an empty scramble',
        (tester) async {
      final visualization =
          ScrambleVisualizer.fromScramble(scramble: emptyScramble).getUpFace();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(9));
    });

    testWidgets(
        'displays 9 squares when visualizing up face with an error scramble',
        (tester) async {
      final visualization =
          ScrambleVisualizer.fromScramble(scramble: errorScramble).getUpFace();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(9));
    });

    testWidgets('displays 54 squares when visualizing cube', (tester) async {
      final visualization =
          ScrambleVisualizer.fromScramble(scramble: scramble).getCube();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(54));
    });

    testWidgets(
        'displays 54 squares when visualizing cube with an empty scramble',
        (tester) async {
      final visualization =
          ScrambleVisualizer.fromScramble(scramble: emptyScramble).getCube();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(54));
    });

    testWidgets(
        'displays 54 squares when visualizing cube with an error scramble',
        (tester) async {
      final visualization =
          ScrambleVisualizer.fromScramble(scramble: errorScramble).getCube();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(54));
    });

    testWidgets('displays 54 squares when visualizing loading cube',
        (tester) async {
      final visualization = ScrambleVisualizer.loading().getCube();
      await tester.pumpVisualization(visualization);
      expect(find.byType(Container), findsNWidgets(54));
    });
  });
}
