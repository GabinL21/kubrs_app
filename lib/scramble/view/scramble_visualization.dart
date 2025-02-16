import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/scramble/utils/scramble_visualizer.dart';

class ScrambleVisualization extends StatelessWidget {
  const ScrambleVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrambleBloc, ScrambleState>(
      builder: (context, state) {
        final scramble = state.scramble;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: state is! ScrambleLoaded
              ? ScrambleVisualizer.loading().getCube()
              : ScrambleVisualizer.fromScramble(scramble: scramble).getCube(),
        );
      },
    );
  }
}
