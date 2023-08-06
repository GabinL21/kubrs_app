import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';

abstract class TagToggleButton extends StatelessWidget {
  const TagToggleButton({
    super.key,
  });

  String getButtonText();
  SolveEvent getSolveEvent(Solve solve);
  bool isButtonActivated(Solve solve);

  @override
  Widget build(BuildContext context) {
    final solveBloc = BlocProvider.of<SolveBloc>(context);
    return BlocBuilder(
      bloc: solveBloc,
      builder: (context, state) {
        if (state is! SolveDone) return Container();
        final solveEvent = getSolveEvent(state.solve);
        return TextButton(
          onPressed: () => solveBloc.add(solveEvent),
          child: Text(
            getButtonText(),
            style: _getTextStyle(context, state.solve),
          ),
        );
      },
    );
  }

  TextStyle _getTextStyle(BuildContext context, Solve solve) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;
    final colorScheme = Theme.of(context).colorScheme;
    final color =
        isButtonActivated(solve) ? colorScheme.tertiary : colorScheme.secondary;
    return textStyle.copyWith(
      color: color,
    );
  }
}
