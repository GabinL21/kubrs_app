import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';

class ToggleDNFTagButton extends StatelessWidget {
  const ToggleDNFTagButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final solveBloc = BlocProvider.of<SolveBloc>(context);
    return TextButton(
      onPressed: () => solveBloc.add(ToggleDNFTag()),
      child: Text(
        'DNF',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
