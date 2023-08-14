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
          child: state is! ScrambleLoaded
              ? ScrambleVisualizer.getLoadingCube()
              : ScrambleVisualizer.getCube(scramble),
        );
      },
    );
  }
}
