import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class ToggleDNFTagButton extends StatelessWidget {
  const ToggleDNFTagButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final solveBloc = BlocProvider.of<SolveBloc>(context);
    return BlocBuilder(
      bloc: solveBloc,
      builder: (context, state) {
        if (state is! SolveDone) return Container();
        return TextButton(
          onPressed: () => solveBloc.add(ToggleDNFTag(solve: state.solve)),
          child: Text(
            'DNF',
            style: _getTextStyle(context, state.solve),
          ),
        );
      },
    );
  }

  TextStyle _getTextStyle(BuildContext context, Solve solve) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;
    final colorScheme = Theme.of(context).colorScheme;
    final color = solve.dnf ? colorScheme.tertiary : colorScheme.secondary;
    return textStyle.copyWith(
      color: color,
    );
  }
}