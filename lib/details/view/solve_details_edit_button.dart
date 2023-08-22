import 'package:flutter/material.dart';
import 'package:kubrs_app/solve/model/solve.dart';

class SolveDetailsEditButton extends StatelessWidget {
  const SolveDetailsEditButton({super.key, required this.solve});

  final Solve solve;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {},
      icon: Icon(
        Icons.edit_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
